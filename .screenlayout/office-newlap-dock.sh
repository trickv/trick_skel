#!/bin/sh
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI-1 --off --output DP-1 --off --output DP-2 --off --output DP-2-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2-2 --mode 1920x1080 --pos 3840x0 --rotate normal --output DP-2-3 --off

link=$(basename $(realpath -P $0))
cd $(dirname $(realpath $0))
rm -f hotkey.sh
ln -s $link hotkey.sh
