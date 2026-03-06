#!/usr/bin/env bash
DEV="intel_backlight"
ACT=$(brightnessctl -d "$DEV" g)
STEPS=(0 100 1000 2000 4000 6000 12000 24000 48000 96000)

# find nearest step index
IDX=0
for i in "${!STEPS[@]}"; do
    if [ "${STEPS[$i]}" -le "$ACT" ]; then
        IDX=$i
    fi
done

if [ "$1" == "+" ]; then
    if [ $((IDX + 1)) -lt ${#STEPS[@]} ]; then
        NEW=${STEPS[$((IDX + 1))]}
    else
        NEW=${STEPS[$IDX]}
        notify-send --expire-time 500 "brightness MAX"
    fi
elif [ "$1" == "-" ]; then
    if [ $IDX -gt 0 ]; then
        NEW=${STEPS[$((IDX - 1))]}
        if [ $((IDX - 1)) -eq 1 ]; then
            notify-send --expire-time 2000 "brightness $NEW"
        fi
    else
        NEW=0
        # notify-send --expire-time 500 "brightness OFF"
    fi
else
    exit 1
fi

# notify-send --expire-time 500 "brightness $NEW"
brightnessctl -d "$DEV" -q s "$NEW"
exit 0
