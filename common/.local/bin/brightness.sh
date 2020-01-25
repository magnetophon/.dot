#!/usr/bin/env bash

MAX=$(cat /sys/class/backlight/intel_backlight/max_brightness)
ACT=$(cat /sys/class/backlight/intel_backlight/actual_brightness)
MIN=4

if [ "$1" == "+" ]; then
    NEW=$(((ACT/2)*3))
elif [ "$1" == "-" ]; then
    NEW=$((ACT-(ACT/3)))
fi

if [ $NEW -ge "$MAX" ]; then
    NEW=$MAX
fi

if [ $NEW -le $MIN ]; then
    NEW=$MIN
fi

light -Sr $NEW

# notify-send --expire-time 500 "brightness $NEW"

exit 0
