#!/usr/bin/env bash
flag=/tmp/yazi-screen-inverted

xcalib -i -a

if [ -e "$flag" ]; then
    rm "$flag"
else
    touch "$flag"
fi
