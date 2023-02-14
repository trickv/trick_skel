#!/bin/sh
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x1080 --rotate normal --output HDMI-1 --off --output DP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-2 --off --output DP-1-1 --off --output DP-1-2 --off --output DP-1-3 --off

cd $(dirname $(realpath $0))
pwd
rm hotkey.sh
ln -s $(basename $(realpath -P $0)) hotkey.sh
