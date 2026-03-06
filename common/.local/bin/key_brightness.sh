#!/usr/bin/env bash
KB_DEV="chromeos::kbd_backlight"
POWER_DEV="chromeos:multicolor:power"
ACT=$(brightnessctl -d "$KB_DEV" g)
POWER_OFF=20
STEPS=(0 1 4 8 20 50 100)

echo "ACT=$ACT"

# make the power led white
echo "0 0 0 0 100 0" > /sys/class/leds/chromeos:multicolor:power/multi_intensity

# find nearest step index
IDX=0
for i in "${!STEPS[@]}"; do
    if [ "${STEPS[$i]}" -le "$ACT" ]; then
        IDX=$i
    fi
done

# echo "nearest step index: $IDX (${STEPS[$IDX]})"

if [ "$1" == "+" ]; then
    # echo "direction: UP"
    if [ $((IDX + 1)) -lt ${#STEPS[@]} ]; then
        NEW=${STEPS[$((IDX + 1))]}
    else
        NEW=${STEPS[$IDX]}
        notify-send --expire-time 500 "keyboard brightness MAX"
    fi
elif [ "$1" == "-" ]; then
    # echo "direction: DOWN"
    if [ $IDX -gt 0 ]; then
        NEW=${STEPS[$((IDX - 1))]}
    else
        NEW=0
        notify-send --expire-time 500 "keyboard backlight OFF"
    fi
else
    echo "no direction given, arg was: '$1'"
    exit 1
fi

# echo "setting brightness: $NEW (was $ACT)"
notify-send --expire-time 500 "keyboard brightness $NEW"

if [ $NEW -lt $POWER_OFF ]; then
    # echo "power LED off (NEW=$NEW < POWER_OFF=$POWER_OFF)"
    brightnessctl -d "$POWER_DEV" -q s 0
else
    # echo "power LED on"
    brightnessctl -d "$POWER_DEV" -q s 100
fi

if [ $NEW -ne $ACT ]; then
    # echo "writing $NEW to $KB_DEV"
    brightnessctl -d "$KB_DEV" s "$NEW"
fi

exit 0
