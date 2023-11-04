#!/usr/bin/env zsh

source tricky-fino.zsh-theme

for h in ultracoin litecoin CHI-Linux-L-016 mash shell minor sparge; do
    function box_name {
        echo $h
    }
    box_color
    echo $h
    echo
done
