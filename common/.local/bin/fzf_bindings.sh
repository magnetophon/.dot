#!/usr/bin/env sh

grep '^bind' ~/.config/i3/config | cut -d ' ' -f 2- | sed 's/ //' | column --table --separator  | fzf --preview-window=hidden
