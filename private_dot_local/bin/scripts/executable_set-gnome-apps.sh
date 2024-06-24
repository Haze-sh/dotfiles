#!/bin/sh

exec swhkd.start & disown
exec ssh-agent -D -a $SSH_AUTH_SOCK & disown
exec gammastep & disown
exec mpDris2 & disown
exec playerctld daemon & disown
exec play $HOME/Music/Classical\ Library/'1-01 Beethoven Symphony 5 in C Minor, Op. 67 - 1. Allegro Con Brio (CUT).mp3' >/dev/null 2>&1 & disown
exec wl-paste -t text --watch clipman store & disown
exec wl-paste -t text --watch clipman-clear & disown
exec ydotoold --socket-path /tmp/.ydotool_socket --socket-perm 0660 & disown
exec moonphase & disown
exec safeeyes & disown
exec mpv_history_daemon_restart $HPIDATA/MPV & disown
exec python3 ~/.local/bin/inkscape-shortcut-manager/main.py & disown
exec syncthing -no-browser & disown
exec mopidy & disown
exec beet web & disown
exec rescrobbled & disown
exec /opt/activitywatch/aw-server-rust/aw-server-rust & disown
exec $HOME/.local/bin/promnesia/scripts/promnesia serve & disown
exec dbus-launch kdeconnect-cli -l & disown
exec otd-daemon & disown
exec blueman-applet & disown
exec gitwatch ~/Documents/Notes/Personal/Collections & disown
exec gitwatch ~/Documents/Notes/Personal/Courses & disown
sudo NetworkManager
