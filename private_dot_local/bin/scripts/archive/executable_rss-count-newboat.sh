#!/bin/sh
sqlite3 ~/.local/share/newsboat/cache.db <<EOF
select count(*) from rss_item where unread=1;
EOF
