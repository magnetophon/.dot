#!/bin/sh

# Give dmenu list of all unicode characters to copy.
# Shows the selected character in dunst if running.

# Must have xclip installed to even show menu.
xclip -h >/dev/null || exit

# if [ -e ~/.config/fontawesome ]; then
# chosen=$(grep -v "#" -h ~/.config/emoji ~/.config/fontawesome | dmenu -l 20 -fn Monospace-18)
# else
chosen=$(grep -v "#" ~/.config/emoji | rofi -dmenu -i -p "type and copy")
# fi

[ "$chosen" != "" ] || exit

c=$(echo "$chosen" | sed "s/ .*//")
echo "$c" | tr -d '\n' | xclip -selection clipboard
xdotool type "$c"
notify-send -t 3000 "'$c' typed and copied to clipboard." &

# s=$(echo "$chosen" | sed "s/.*; //" | awk '{print $1}')
# echo "$s" | tr -d '\n' | xclip
# notify-send "'$s' copied to primary." &
