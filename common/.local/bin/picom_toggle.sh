#!/usr/bin/env bash

if pgrep -x "picom" > /dev/null
then
	killall picom
    notify-send --expire-time 500 "picom stopped"
else
	picom -b
    notify-send --expire-time 500 "picom started"
fi
