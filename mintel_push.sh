#!/bin/sh

ssh -i ~/.ssh/id_rsa willow rm -rf ~/src/trick_skel
scp -i ~/.ssh/id_rsa -r `pwd` willow:~/src/trick_skel

ssh -i ~/.ssh/id_rsa doobie rm -rf ~/src/trick_skel
scp -i ~/.ssh/id_rsa -r `pwd` doobie:~/src/trick_skel
