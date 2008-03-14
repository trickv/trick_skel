#!/bin/sh

atlas=172.17.2.53

rsync rsync://${atlas}/trick_skel/ $HOME/src/trick_skel -a --delete
