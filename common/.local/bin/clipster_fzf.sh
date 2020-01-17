#!/usr/bin/env bash

clipster -o -n 10000 -0 | fzf --read0 --no-sort --reverse --preview='echo {}' | sed -ze 's/\n$//' | clipster
