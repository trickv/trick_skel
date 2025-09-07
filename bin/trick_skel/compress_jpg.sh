#!/bin/bash

# Usage: ./compress_jpg.sh input.jpg

input="$1"
max_size=$((2 * 1024 * 1024))  # 2MB in bytes
temp_file="temp_$$.jpg"
quality=95

cp "$input" "$temp_file"

while [ $(stat -c%s "$temp_file") -gt $max_size ] && [ $quality -gt 10 ]; do
    convert "$input" -resize 2000x2000\> -interlace JPEG -quality $quality "$temp_file"
    ((quality -= 5))
done

if [ $(stat -c%s "$temp_file") -le $max_size ]; then
    mv "$temp_file" "$input"
    echo "Compressed '$input' to under 2MB at quality $quality."
else
    rm "$temp_file"
    echo "Could not compress '$input' to under 2MB even at low quality."
fi
