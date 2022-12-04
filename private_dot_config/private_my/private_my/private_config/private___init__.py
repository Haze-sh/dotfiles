from os import environ, path
from typing import Optional, Callable, List, Set
from pathlib import Path
from my.core import Paths, PathIsh
# from .common import repo


def if_exists(p: PathIsh) -> Optional[Path]:
    pp = Path(p)
    if pp.exists():
        return pp
    return None


def filter_exists(pths: List[PathIsh]) -> List[Path]:
    res: List[Path] = []
    for p in pths:
        r = if_exists(p)
        if r is not None:
            res.append(r)
    return res


PREFIX: Path = Path(environ.get("HPIDATA"))


def data(p: PathIsh) -> Path:
    return PREFIX / p


FILTER_PARTS: Set[str] = {".notmuch", "Trash", "Spam", "Junk"}
MAILDIR = environ.get("MAILDIR", "~/.local/share/mail")


def filter_mail_path(p: Path) -> bool:
    pset = set(p.parts[1:])
    if any(f in pset for f in FILTER_PARTS):
        return False
    return True


class mail:
    class imap:
        mailboxes = MAILDIR
        filter_path: Optional[Callable[[Path], bool]] = filter_mail_path


class smscalls:
    export_path: Paths = data("SMSBackups")


class zsh:
    export_path: Paths = data("zsh_history")
    live_file: Optional[PathIsh] = if_exists(environ.get("HISTFILE"))


class todotxt:
    class git_history:
        export_path: Paths = environ.get("TODO_FILE", "DONE_FILE")


live_dbs: List[Path] = []
try:
    from browserexport.browsers.firefox import Firefox

    live_dbs.append(Firefox.locate_database())
except Exception:
    pass


class browser:      # https://github.com/seanbreckenridge/browserexport
    export_path: Paths = data('Browser')

    class active_browser:
        export_path: Paths = data('Browser')


class location:
    class gpslogger:
        export_path: Paths = data('Places')
        accuracy: float = 50.0


class time:
    class tz:
        policy = 'convert'

        class via_location:
            fast: bool = True
            sort_locations: bool = True
            require_accuracy: float = 5_000


PREFIX: Path = Path(environ.get("ZET_DIR"))


def annotations(p: PathIsh) -> Path:
    return PREFIX / p


class hypothesis:       # https://github.com/karlicoss/hypexport
    export_path: Paths = annotations('Annotations/hyp-annotations.json')


# class commits:
#     try:
#         from .commits_secret import emails, names
#
#         emails = emails
#         names = names
#     except ImportError:
#         pass
#
#     roots: Paths = filter_exists(
#         [
#             repo(""),
#             path.expanduser(environ.get('REPOS')),
#         ]
#     )


class mpv:      # https://github.com/seanbreckenridge/mpv-history-daemon
    class history_daemon:
        export_path: Paths = data("mpv/*.json")
        require_percent = 0.5
