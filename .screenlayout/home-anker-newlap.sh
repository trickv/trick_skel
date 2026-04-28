#!/bin/sh
xrandr --output eDP-1 --mode 1920x1080 --pos 0x1440 --rotate normal --output DP1 --off --output DP-2 --mode 2560x1440 --pos 0x0 --rotate normal --output HDMI1 --off --output VIRTUAL1 --off --output VIRTUAL2 --off

link=$(basename $(realpath -P $0))
cd $(dirname $(realpath $0))
rm -f hotkey.sh
ln -s $link hotkey.sh
