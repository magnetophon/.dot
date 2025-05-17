#!/usr/bin/env sh
set -eux
cd scripts


curl -fLOJSs --output-dir ../script-modules https://github.com/Seme4eg/mpv-scripts/raw/master/script-modules/extended-menu.lua
# curl -fLOJSs --output-dir ../script-opts https://github.com/Seme4eg/mpv-scripts/raw/master/script-opts/M_x.conf
# curl -fLOJSs --output-dir ../script-opts https://github.com/cvzi/mpv-youtube-download/raw/refs/heads/main/youtube-download.conf


curl -fLOJSs https://github.com/Seme4eg/mpv-scripts/raw/master/M-x.lua
curl -fLOJSs https://github.com/cvzi/mpv-youtube-download/raw/refs/heads/main/youtube-download.lua
curl -fLOJSs https://github.com/4e6/mpv-reload/raw/refs/heads/master/main.lua
mv main.lua reload.lua
curl -fLOJSs https://github.com/mpv-player/mpv/raw/refs/heads/master/TOOLS/lua/acompressor.lua
