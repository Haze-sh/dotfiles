#!/usr/bin/env bash

pid=$(pgrep gammastep)

if [[ $1 = "toggle" ]]; then
	if pgrep -x "gammastep" > /dev/null; then
		kill -9 $(pgrep -x "gammastep");
	else
		gammastep -O ${GAMMASTEP_NIGHT:-4500} &
	fi
fi

if pgrep -x "gammastep" > /dev/null; then
	echo ""
	notify-send "Nightlight is on"
else
	echo ""
	notify-send "Nightlight is off"
fi
