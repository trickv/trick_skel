#!/bin/sh

cmd="cd src/trick_skel && svn up && ./install.sh"

STANDARD_HOSTS="trick@sting trick@mc trick@atlas root@sam trick@sam"

for host in $STANDARD_HOSTS; do
    ssh $host "${cmd}"
done

