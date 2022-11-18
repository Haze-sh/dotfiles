from promnesia.common import Source
from promnesia.sources import auto

'''
List of sources to use.

You can specify your own, add more sources, etc.
See https://github.com/karlicoss/promnesia#setup for more information
'''
SOURCES = [
    Source(
        auto.index,
        '~/Documents/Notes/Personal/Journal/Collections',
        ignored=[ '.lock', '*.html', '*.json', '*.yml', '*.toml', '*.org', '*.xbel', '*.ods', '*.xlsx', '*.csv', '*.kdbx', '*.xopp', '*.pdf', '*.jrnl', '*.ledger', '*.db'],
        name='Markdown Notes',
    ),
    Source(
        auto.index,
        '~/Documents/Notes/Personal/Journal/GTD',
        ignored=['*.org', '*.jrnl', '*.bak'],
        name='Journals & TODO',
    ),
]
