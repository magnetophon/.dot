#!/usr/bin/env bash


function notify-send() {
    #Detect the name of the display in use
    local display=":$(ls /tmp/.X11-unix/* | sed 's#/tmp/.X11-unix/X##' | head -n 1)"

    #Detect the user using such display
    local user=$(who | grep '('$display')' | awk '{print $1}' | head -n 1)

    #Detect the id of the user
    local uid=$(id -u $user)

    sudo -u $user DISPLAY=$display DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$uid/bus notify-send "$@"
}

MAX=100
ACT=$(/run/current-system/sw/bin/ectool pwmgetkblight | grep -o '[0-9]\+')
MIN=1
# toggle the power button light when the kb light crosses this value.
POWER_OFF=20

# we are going up
if [ "$1" == "+" ]; then
    # at least $MIN
    if [ $ACT -lt "$MIN" ]; then
       NEW=$MIN
    else 
        # new value
        NEW=$((ACT*2))
        # at most $MAX
        if [ $NEW -gt "$MAX" ]; then
            NEW=$MAX
            notify-send --expire-time 500 "keyboard brightness MAX"
        fi
    fi
# we are going down
elif [ "$1" == "-" ]; then
    # new value
    NEW=$((ACT/2))
    # if the proposed new value is less than $MIN, go to 0
    if [ $NEW -lt $MIN ]; then
        NEW=0
        notify-send --expire-time 500 "keyboard backlight OFF"
    fi
fi

# turn of the power light when the kb brightness is below $POWER_OFF
if [ $NEW -lt $POWER_OFF ]; then
   # notify-send --expire-time 500 "power light OFF"
   /run/current-system/sw/bin/ectool led power off
else
   # notify-send --expire-time 500 "power light ON"
   /run/current-system/sw/bin/ectool led power auto
fi


if [ $NEW -ne $ACT ]; then
    # notify-send --expire-time 500 "keyboard brightness $NEW"
    /run/current-system/sw/bin/ectool pwmsetkblight $NEW >/dev/null
fi


exit 0
