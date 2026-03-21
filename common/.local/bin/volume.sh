#!/usr/bin/env bash
# ~/.local/bin/volume.sh

case "$1" in
    up)
        if command -v wpctl &>/dev/null && pgrep -x wireplumber &>/dev/null; then
            wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
        else
            amixer -q -c 0 sset Master playback 3dB+
        fi
        ;;
    down)
        if command -v wpctl &>/dev/null && pgrep -x wireplumber &>/dev/null; then
            wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-
        else
            amixer -q -c 0 sset Master playback 3dB-
        fi
        ;;
    mute)
        if command -v wpctl &>/dev/null && pgrep -x wireplumber &>/dev/null; then
            wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        else
            amixer -q -c 0 sset Master toggle
        fi
        ;;
esac
