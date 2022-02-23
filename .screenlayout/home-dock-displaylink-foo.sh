#!/bin/sh
xrandr --output eDP-1 --mode 1920x1080 --pos 0x1080 --rotate normal --output HDMI-1 --off --output DP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-2 --off --output DVI-I-4-3 --off --output DVI-I-3-4 --off --output DVI-I-2-2 --off --output DVI-I-1-1 --off
if [ $? -eq 1 ]; then
    # some other display name that DisplayLink seems to adopt sometimes
    xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x1080 --rotate normal --output HDMI-1 --off --output DP-1 --off --output HDMI-2 --off --output DVI-I-4-4 --off --output DVI-I-3-3 --off --output DVI-I-2-2 --off --output DVI-I-1-1 --mode 1920x1080 --pos 0x0 --rotate normal
fi
