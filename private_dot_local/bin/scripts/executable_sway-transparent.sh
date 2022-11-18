#!/bin/sh

export TR_IN_OPACITY="0.9"
PID=$(pgrep sway-transparent)

if [[ -z $PID ]]; then
    ${HOME}/.local/bin/sway-transparent
else
    killall tr_in
    ${HOME}/.local/bin/sway-transparent
fi
