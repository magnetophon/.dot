#!/usr/bin/env bash

FILE=/tmp/FAN_MAX


function notify-send() {
    #Detect the name of the display in use
    local display=":$(ls /tmp/.X11-unix/* | sed 's#/tmp/.X11-unix/X##' | head -n 1)"

    #Detect the user using such display
    local user=$(who | grep '('$display')' | awk '{print $1}' | head -n 1)

    #Detect the id of the user
    local uid=$(id -u $user)

    sudo -u $user DISPLAY=$display DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$uid/bus notify-send "$@"
}



if [ ! -f "$FILE" ]; then
  echo 0 > $FILE
fi

FAN_MAX=$(cat $FILE)

if [ "$FAN_MAX" = 0 ]; then
  ectool fanduty 100 >/dev/null
  export FAN_MAX=1
  echo 1 > $FILE
   notify-send --expire-time 500 "MAX FAN SPEED!"
  # echo ON
else
  ectool autofanctrl >/dev/null
  echo 0 > $FILE
   notify-send --expire-time 500 "fan normal"
  # echo OFF
fi

exit 0
