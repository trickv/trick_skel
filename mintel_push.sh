#!/bin/sh

ssh willow rm -rf ~/src/trick_skel
scp -r `pwd` willow:~/src/trick_skel

ssh doobie rm -rf ~/src/trick_skel
scp -r `pwd` doobie:~/src/trick_skel
