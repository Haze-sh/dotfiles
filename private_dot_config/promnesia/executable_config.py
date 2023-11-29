from os import environ
from promnesia.common import Source
from promnesia.sources import auto

COURSES = environ.get("COURSES")
ZET_DIR = environ.get("ZET_DIR")
VAULS_DIR = environ.get("VAULS_DIR")
PILLARS_DIR = environ.get("PILLARS_DIR")
PIPELINES_DIR = environ.get("PIPELINES_DIR")
WORK_NOTES_DIR = environ.get("WORK_NOTES_DIR")

SOURCES = [
    Source(
        auto.index,
        '~/.cache/zsh/history'
    ),
    Source(
        auto.index,
        '~/Backups/Data',
        ignored=['~/Backups/Data/Archive/*', '*.tsv', '*.urls']
    ),
    Source(
        auto.index,
        ZET_DIR,
        ignored=['.app/*', '.ctags.d/*', '.zk/*', '*.toml', '*.db', '*.ctags',
                 '*.org', '*.yml', 'tags'],
        name='Notes',
    ),
    Source(
        auto.index,
        VAULS_DIR,
        ignored=['logseq/*', 'Xournal/*', 'Zettelkasten/*'],
        name='Lists',
    ),
    Source(
        auto.index,
        PILLARS_DIR,
        name='Pillars',
    ),
    Source(
        auto.index,
        PIPELINES_DIR,
        ignored=['*.ledger', '*.org', '*.jrnl', '*.bak'],
        name='Journals & TODO',
    ),
]
