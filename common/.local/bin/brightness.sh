#!/usr/bin/env bash

MAX=$(cat /sys/class/backlight/intel_backlight/max_brightness)
ACT=$(cat /sys/class/backlight/intel_backlight/actual_brightness)
MIN=100

if [ "$1" == "+" ]; then
    if [ $ACT -eq 0 ]; then
        FADE=$((MAX/13))
        while [ $FADE -gt $MIN ]
        do
            FADE=$((22*FADE/23))
            light -Sr $FADE # bright flash. without this it takes too long to get out of 0 brightness
            usleep 10000
            # ACT=$(cat /sys/class/backlight/intel_backlight/actual_brightness)
        done
        light -Sr $MIN
        exit 0
    fi
    NEW=$(((ACT/2)*3))
    # NEW=$(ACT*1.5)
    if [ $NEW -ge "$MAX" ]; then
        NEW=$MAX
        notify-send --expire-time 500 "brightness $NEW"
    fi
elif [ "$1" == "-" ]; then
    NEW=$((ACT-(ACT/3)))
    if [ $NEW -le $MIN ] && [ $NEW -ne 0 ]; then
        if [ $NEW -eq $((MIN-(MIN/3))) ]; then
            NEW=0
        else
            NEW=$MIN
            notify-send --expire-time 2000 "brightness $NEW"
        fi
    fi
fi


light -Sr $NEW

# notify-send --expire-time 500 "brightness $NEW"

exit 0
