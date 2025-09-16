#!/bin/bash

# Generate a random dark color
R=$(shuf -i 5-70 -n 1)
G=$(shuf -i 5-70 -n 1)
B=$(shuf -i 5-70 -n 1)

# Convert to hexadecimal color code
COLOR=$(printf "#%02x%02x%02x" $R $G $B)

# Generate the image
convert -size 1920x1080 xc:$COLOR /tmp/dark_color_image.png

if [ "$1" == "" ]; then
    eog -f /tmp/dark_color_image.png
fi
