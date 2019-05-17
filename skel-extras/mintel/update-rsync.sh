#!/bin/sh

if [ "$1" != "" ]; then
    host=$1
else
    host=huangniu
fi

rsync rsync://$host.shanghai.mintel.ad:49876/trick_skel/ "$HOME/src/trick_skel" -a --delete
