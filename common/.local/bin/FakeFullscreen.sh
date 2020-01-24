#!/usr/bin/env bash

# i3 bar mode hide
if [ "$(i3-msg -t get_bar_config bar-0 | grep dock)" ]; then
    i3 [class="^.*"] border pixel  && i3 bar mode hide
    # i3 [class="^.*"] border pixel  && i3 bar mode invisible
else
    i3 [class="^.*"] border normal && i3 bar mode dock
fi
