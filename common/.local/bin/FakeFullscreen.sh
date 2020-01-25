#!/usr/bin/env bash

# i3 bar mode hide
# if [ "$(i3-msg -t get_bar_config bar-0 | grep dock)" ]; then

MODE=$(i3-msg -t get_tree | jq -r '.. | .nodes? | .[]? | select(.window!=null and .focused==true).border')

if [ $MODE = "normal" ]; then
    i3 [class="^.*"] border pixel
    # i3 bar mode hide
    # i3 bar mode invisible
    polybar-msg cmd hide
else
    i3 [class="^.*"] border normal
    # i3 bar mode dock
    polybar-msg cmd show
fi
