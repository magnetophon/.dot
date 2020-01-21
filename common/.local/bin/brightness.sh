#!/usr/bin/env bash

DEV=/sys/class/backlight/intel_backlight/brightness
MAX=`cat /sys/class/backlight/intel_backlight/max_brightness`
ACT=`cat /sys/class/backlight/intel_backlight/actual_brightness`
MIN=4

if [ $1 == "+" ]; then
    NEW=$(((ACT/2)*3))
    if [ $NEW -ge $MAX ]; then
        NEW=$MAX
    fi
elif [ $1 == "-" ]; then
    NEW=$((ACT-(ACT/3)))
    if [ $NEW -le $MIN ]; then
        NEW=$MIN
    fi
fi

light -Sr $NEW
# notify-send --expire-time 500 "brightness $NEW"

exit 0
