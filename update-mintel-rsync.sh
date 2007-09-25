#!/bin/sh

atlas=172.17.2.255

rsync rsync://${atlas}/trick_skel/ $HOME/src/trick_skel -a --del
