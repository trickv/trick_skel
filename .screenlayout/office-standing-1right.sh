#!/bin/sh
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-1 --off --output HDMI-2 --off --output DP-1-1 --off --output DP-1-2 --mode 1680x1050 --pos 1920x15 --rotate normal --output DP-1-3 --off

link=$(basename $(realpath -P $0))
cd $(dirname $(realpath $0))
rm -f hotkey.sh
ln -s $link hotkey.sh
