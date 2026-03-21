#!/usr/bin/env bash
flag=/tmp/yazi-screen-inverted
css=~/.config/qutebrowser/rotate.css

xrandr-invert-colors
# for some drivers xrandr-invert-colors doesn't work:
# xcalib -i -a

if [ -e "$flag" ]; then
    rm "$flag"
    qutebrowser ':set content.user_stylesheets ""' 2>/dev/null || true
    # sometimes crashes qutebrowser:
    # qutebrowser ":config-list-remove content.user_stylesheets $css" 2>/dev/null || true
else
    touch "$flag"
    qutebrowser ':set content.user_stylesheets ~/.config/qutebrowser/rotate.css' 2>/dev/null || true
    # sometimes crashes qutebrowser:
    # qutebrowser ":config-list-add content.user_stylesheets $css" 2>/dev/null || true
fi
