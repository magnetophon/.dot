#!/usr/bin/env bash
flag=/tmp/yazi-screen-inverted
css=~/.config/qutebrowser/rotate.css

xrandr-invert-colors
# for some drivers xrandr-invert-colors doesn't work:
# xcalib -i -a
pkill picom 2>/dev/null
sleep 0.05
while pgrep -x picom >/dev/null; do sleep 0.01; done

if [ -e "$flag" ]; then
    rm "$flag"
    # stop counter-inverting
    picom --config ~/.config/picom-non-inverted.conf -b
    qutebrowser ':set content.user_stylesheets ""' 2>/dev/null || true
    # sometimes crashes qutebrowser:
    # qutebrowser ":config-list-remove content.user_stylesheets $css" 2>/dev/null || true
else
    touch "$flag"
    # start counter-inverting marked windows
    picom -b
    qutebrowser ':set content.user_stylesheets ~/.config/qutebrowser/rotate.css' 2>/dev/null || true
    # sometimes crashes qutebrowser:
    # qutebrowser ":config-list-add content.user_stylesheets $css" 2>/dev/null || true
fi
