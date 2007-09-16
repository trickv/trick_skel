#!/bin/sh

cmd="cd src/trick_skel && svn up && ./install.sh"

STANDARD_HOSTS="trick@sting trick@mc pv@atlas root@sam trick@sam"

for host in $STANDARD_HOSTS; do
    echo "Deploying to {$host}..."
    ssh $host "${cmd}" > /dev/null
done

