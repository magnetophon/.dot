#!/usr/bin/env bash

if pgrep -x "picom" > /dev/null
then
	killall picom
    notify-send "picom stopped"
else
	picom -b
    notify-send "picom started"
fi
