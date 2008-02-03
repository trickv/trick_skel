#!/bin/sh

cmd="cat .trick_skel/info/txt | grep 'Last Changed Rev'"

HOME_HOSTS="trick@sting root@sting trick@mc root@mc trick@sam root@sam"
WORK_HOSTS="pv@gasket pv@raquel pv@baldrick pv@darth pv@willow pv@atlas root@atlas"

case "$1" in
    work) HOST_LIST=$WORK_HOSTS;;
    home) HOST_LIST=$HOME_HOSTS;;
    *) echo "Sorry, you need to specify a host list (home or work)."; exit 1;;
esac

for host in $HOST_LIST; do
    echo -n $host ' '
    ssh $host "${cmd}"
done

