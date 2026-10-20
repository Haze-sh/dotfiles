#!/usr/bin/env python3
"""
Generate AI-powered tags for existing Linkwarden links.

Usage:
    LINKWARDEN_BASE_URL="https://your-instance" \
    LINKWARDEN_TOKEN="<access token>" \
    LINKWARDEN_SEARCH_PATH="/api/v1/search" \
    LINKWARDEN_LINK_PATH="/api/v1/links" \
    OPENAI_BASE_URL="https://api.openai.com" \
    OPENAI_CHAT_PATH="/v1/chat/completions" \
    OPENAI_API_KEY="<api key>" \
    OPENAI_MODEL="gpt-4o-mini" \
    python scripts/generate_ai_tags.py

Environment variables:
    LINKWARDEN_BASE_URL  Base URL of your Linkwarden instance (default: http://localhost:3000).
    LINKWARDEN_SEARCH_PATH  Search endpoint path (default: /api/v1/search).
    LINKWARDEN_LINK_PATH    Link update endpoint path (default: /api/v1/links).
    LINKWARDEN_TOKEN     Access token or session token with permission to update links.
    OPENAI_BASE_URL      Base URL for the OpenAI-compatible service (default: https://api.openai.com).
    OPENAI_CHAT_PATH     Chat completions endpoint path (default: /v1/chat/completions).
    OPENAI_API_KEY       API key for the configured OpenAI-compatible service.
    OPENAI_MODEL         Model name to use (default: gpt-4o-mini).

The script fetches links from the search endpoint, skips items that already have
tags or are marked as aiTagged, generates up to five concise tags with an LLM, and
updates each link via the public API.
"""

import ast
import json
import os
import sys
from typing import Iterable, List, Optional

import requests

RAW_BASE_URL = os.getenv("LINKWARDEN_BASE_URL", "http://localhost:3000")
LINKWARDEN_SEARCH_PATH = os.getenv("LINKWARDEN_SEARCH_PATH", "/api/v1/search")
LINKWARDEN_LINK_PATH = os.getenv("LINKWARDEN_LINK_PATH", "/api/v1/links")
TOKEN = os.getenv("LINKWARDEN_TOKEN")
RAW_OPENAI_BASE_URL = os.getenv("OPENAI_BASE_URL", "https://api.openai.com")
OPENAI_CHAT_PATH = os.getenv("OPENAI_CHAT_PATH", "/v1/chat/completions")
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
OPENAI_MODEL = os.getenv("OPENAI_MODEL", "gpt-4o-mini")


def require(value: Optional[str], name: str) -> str:
    if not value:
        sys.exit(f"Missing required environment variable: {name}")
    return value


def normalize_base_url(raw: str, name: str = "BASE_URL") -> str:
    """Return a sanitized base URL string.

    Some Windows setups can accidentally pass a tuple repr like
    "('LINKWARDEN_BASE_URL', 'https://example.com')"; we attempt to
    recover the actual URL from such strings and ensure there is a
    scheme present so requests can build a valid URL.
    """

    # Trim whitespace and surrounding quotes
    raw = (raw or "").strip().strip('"\'')

    # Attempt to parse tuple-like reprs
    if raw.startswith("(") and raw.endswith(")"):
        try:
            parsed = ast.literal_eval(raw)
            if isinstance(parsed, tuple) and len(parsed) == 2:
                raw = str(parsed[1])
        except (SyntaxError, ValueError):
            pass

    raw = raw.rstrip("/")
    if not raw.startswith("http://") and not raw.startswith("https://"):
        sys.exit(f"{name} must include a scheme, e.g. https://example.com")
    return raw


BASE_URL = normalize_base_url(RAW_BASE_URL, "LINKWARDEN_BASE_URL")
OPENAI_BASE_URL = normalize_base_url(RAW_OPENAI_BASE_URL, "OPENAI_BASE_URL")


def join_url(base: str, path: str) -> str:
    path = path or ""
    if not path.startswith("/"):
        path = "/" + path
    return base.rstrip("/") + path


def fetch_links(session: requests.Session) -> Iterable[dict]:
    """Yield all links from the search API."""
    cursor = 0
    while True:
        resp = session.get(
            join_url(BASE_URL, LINKWARDEN_SEARCH_PATH), params={"cursor": cursor}
        )
        resp.raise_for_status()
        payload = resp.json().get("data", {})
        links = payload.get("links", [])
        for link in links:
            yield link
        cursor = payload.get("nextCursor")
        if cursor is None:
            break


PROMPT_SYSTEM = (
    "Return only a JSON array of up to 5 short tags (1-2 words) that summarize "
    "the provided text. Use the text language. If no tags apply, return []."
)


def trim_text(text: str, limit: int = 1000) -> str:
    compact = " ".join((text or "").split())
    return compact[:limit]


def request_tags(text: str) -> List[str]:
    if not text:
        return []

    content = trim_text(text)
    resp = requests.post(
        join_url(OPENAI_BASE_URL, OPENAI_CHAT_PATH),
        headers={
            "Authorization": f"Bearer {require(OPENAI_API_KEY, 'OPENAI_API_KEY')}",
            "Content-Type": "application/json",
        },
        json={
            "model": OPENAI_MODEL,
            "messages": [
                {"role": "system", "content": PROMPT_SYSTEM},
                {"role": "user", "content": content},
            ],
            "temperature": 0.1,
            "max_tokens": 80,
        },
        timeout=60,
    )
    resp.raise_for_status()
    message = resp.json()["choices"][0]["message"]["content"].strip()

    try:
        parsed = json.loads(message)
        if isinstance(parsed, list):
            return [str(tag) for tag in parsed][:5]
    except json.JSONDecodeError:
        pass

    start = message.find("[")
    end = message.rfind("]")
    if start != -1 and end != -1:
        try:
            return [str(t) for t in json.loads(message[start : end + 1])][:5]
        except json.JSONDecodeError:
            return []
    return []


def build_update_payload(link: dict, tags: List[str]) -> Optional[dict]:
    if not link.get("collection"):
        return None

    existing = link.get("tags", [])
    existing_names = {t.get("name") for t in existing if t.get("name")}
    new_tags = [t for t in tags if t and t not in existing_names]
    if not new_tags:
        return None

    tag_payload = [
        {"id": tag.get("id"), "name": tag["name"]}
        for tag in existing
        if tag.get("name")
    ] + [{"name": tag[:50]} for tag in new_tags][:5]

    pinned = link.get("pinnedBy")
    pinned_payload = None
    if isinstance(pinned, list):
        pinned_payload = [{"id": item.get("id")} for item in pinned if item]

    return {
        "id": link["id"],
        "name": link.get("name") or "",
        "url": link.get("url"),
        "description": link.get("description") or "",
        "icon": link.get("icon"),
        "iconWeight": link.get("iconWeight"),
        "color": link.get("color"),
        "collection": {
            "id": link.get("collectionId") or link["collection"]["id"],
            "ownerId": link["collection"].get("ownerId"),
        },
        "tags": tag_payload,
        **({"pinnedBy": pinned_payload} if pinned_payload is not None else {}),
    }


def main() -> None:
    require(TOKEN, "LINKWARDEN_TOKEN")
    require(OPENAI_API_KEY, "OPENAI_API_KEY")

    session = requests.Session()
    session.headers.update({"Authorization": f"Bearer {TOKEN}"})

    for link in fetch_links(session):
        if link.get("aiTagged"):
            continue
        if link.get("tags"):
            continue

        text_source = (
            link.get("description")
            or link.get("textContent")
            or link.get("name")
            or link.get("url")
        )

        tags = request_tags(text_source or "")
        payload = build_update_payload(link, tags)
        if not payload:
            continue

        link_path = LINKWARDEN_LINK_PATH.rstrip("/") if LINKWARDEN_LINK_PATH else "/api/v1/links"
        resp = session.put(
            join_url(BASE_URL, f"{link_path}/{link['id']}"), json=payload, timeout=30
        )
        resp.raise_for_status()
        print(f"Updated link {link['id']} with tags: {tags}")


if __name__ == "__main__":
    main()
