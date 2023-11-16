from os import environ
from promnesia.common import Source
from promnesia.sources import auto
# from promnesia.sources import hypothesis

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
        ignored=['~/Backups/Data/Archive/*', '~/Backups/Data/URLS/*',
                 '*.tsv', '*.urls']
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
        name='List Notes',
    ),
    Source(
        auto.index,
        PILLARS_DIR,
        name='Pillar Notes',
    ),
    Source(
        auto.index,
        PIPELINES_DIR,
        ignored=['*.ledger', '*.org', '*.jrnl', '*.bak'],
        name='Journals & TODO',
    ),
]
#    Source(
#        auto.index,
#        COURSES,
#        ignored=['*.latexmain']
#    ),
#    Source(
#        auto.index,
#        WORK_NOTES_DIR,
#    ),
#    Source(
#        auto.index,
#        '~/.local/share/calendars'
#    ),
#    Source(
#        auto.index,
#        '~/.local/share/mail'
#    ),
#   ]
