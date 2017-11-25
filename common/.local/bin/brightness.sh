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
        echo $((ACT*2)) > $DEV
    else
        echo $MAX > $DEV
    fi
elif [ $1 == "-" ]; then
    if [ $((ACT/2)) -ge $MIN ]; then
        echo $((ACT/2)) > $DEV
    else
        echo $MIN > $DEV
    fi
fi

exit 0
