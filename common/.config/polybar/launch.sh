#!/usr/bin/env bash

# Terminate already running bar instances
kill "$(pidof polybar)"
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log # /tmp/polybar2.log
polybar bar1 >>/tmp/polybar1.log 2>&1 &
# polybar bar2 >>/tmp/polybar2.log 2>&1 &

echo "Bars launched..."

sleep 5

MODE=$(i3-msg -t get_tree | jq -r '.. | .nodes? | .[]? | select(.window!=null and .focused==true).border')
if [ "$MODE" != "normal" ]; then
    polybar-msg cmd hide
    echo "Bars hidden..."
fi


