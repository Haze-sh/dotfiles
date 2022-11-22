from promnesia.common import Source
from promnesia.sources import auto
# from promnesia.sources import hypothesis

SOURCES = [
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
        '~/Documents/Notes/Personal/Journal/Collections',
        ignored=['*.lock', '*.html', '*.yml', '*.toml', '*.org',
                 '*.xbel', '*.ods', '*.xlsx', '*.csv', '*.kdbx', '*.xopp',
                 '*.pdf', '*.jrnl', '*.ledger', '*.db'],
        name='Notes',
    ),
    Source(
        auto.index,
        '~/Documents/Notes/Personal/Journal/GTD',
        ignored=['*.org', '*.jrnl', '*.bak'],
        name='Journals & TODO',
    ),
    Source(
        auto.index,
        '~/Documents/Notes/Personal/Courses'
    ),
]
#    Source(
#        auto.index,
#        '~/Documents/Notes/Workspace'
#    ),
#    Source(
#        auto.index,
#        '~/.local/share/calendars'
#    ),
#   ]
