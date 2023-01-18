from os import environ
from promnesia.common import Source
from promnesia.sources import auto
# from promnesia.sources import hypothesis

ZET_DIR = environ.get("ZET_DIR")
GTD_DIR = environ.get("GTD_DIR")
COURSES = environ.get("COURSES")
WORK_NOTES_DIR = environ.get("WORK_NOTES_DIR")

SOURCES = [
    Source(
        auto.index,
        '~/Backups/Data',
        ignored=['~/Backups/Data/Archive/*', '~/Backups/Data/URLS/*',
                 '*.tsv', '*.urls']
    ),
    Source(
        auto.index,
        '~/.local/share/mail'
    ),
    Source(
        auto.index,
        '~/.cache/zsh/history'
    ),
    Source(
        auto.index,
        ZET_DIR,
        ignored=['*.lock', '*.html', '*.yml', '*.toml', '*.org',
                 '*.xbel', '*.ods', '*.xlsx', '*.csv', '*.kdbx', '*.xopp',
                 '*.pdf', '*.jrnl', '*.ledger', '*.db'],
        name='Notes',
    ),
    Source(
        auto.index,
        GTD_DIR,
        ignored=['*.org', '*.jrnl', '*.bak'],
        name='Journals & TODO',
    ),
    Source(
        auto.index,
        COURSES,
    ),
]
#    Source(
#        auto.index,
#        WORK_NOTES_DIR,
#    ),
#    Source(
#        auto.index,
#        '~/.local/share/calendars'
#    ),
#   ]
