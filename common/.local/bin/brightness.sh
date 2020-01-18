#!/usr/bin/env bash

DEV=/sys/class/backlight/intel_backlight/brightness
MAX=`cat /sys/class/backlight/intel_backlight/max_brightness`
ACT=`cat /sys/class/backlight/intel_backlight/actual_brightness`
MIN=1
# STEPS=30
# STEP=$((MAX/STEPS))
# STEP=20

if [ $1 == "+" ]; then
    if [ $((ACT*2)) -le $MAX ]; then
        light -Sr $(((ACT/2)*3))
    else
        light -Sr $MAX
    fi
elif [ $1 == "-" ]; then
    if [ $((ACT/2)) -ge $MIN ]; then
        light -Sr $((ACT-(ACT/3)))
    else
        light -Sr $MIN
    fi
fi

exit 0
