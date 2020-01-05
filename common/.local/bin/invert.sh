#!/usr/bin/env bash
#
# This script will adjust the class name on the window
# It will allow you to adjust your compton config to match
#
# add to compton's config:
# invert-color-include = [
#     "class_g ~= '-Inverted$'"
#



re="(.*)-Inverted$"
ID=$(xdotool getactivewindow)
CLASS=$(xprop -id "$ID"  | grep "WM_CLASS" | awk -F'"' '{print $4}')

if  [[ $CLASS =~ $re ]]; then
  xdotool set_window --class "${BASH_REMATCH[1]}" $ID
else
  xdotool set_window --class "$CLASS-Inverted" $ID
fi


if ! pgrep -x "picom" > /dev/null
then
	picom -b
    notify-send "picom started"
fi
