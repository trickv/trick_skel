#!/usr/bin/env bash

INSTALL_DOTFILES=".screenrc .vimrc .bash_profile_trick_skel"

#####

mkdir -p $HOME/tmp/trick_skel_backup

echo -n "Backing up "
for cur in $INSTALL_DOTFILES; do
    pushd $HOME > /dev/null
    echo -n "$cur, "
    cp $cur $HOME/tmp/trick_skel_backup
    popd > /dev/null
done
echo

tar cfj $HOME/tmp/trick_skel_backup-`date -u "+%Y%m%d-%H%M%S"`.tar.bz2 $HOME/tmp/trick_skel_backup > /dev/null
rm -rf $HOME/tmp/trick_skel_backup

echo -n "Installing "
for cur in $INSTALL_DOTFILES; do
    echo -n "$cur, "
    cp skel/$cur $HOME/$cur
done
echo

grep bash_profile_trick_skel $HOME/.bash_profile &> /dev/null
if [ $? -ne 0 ]; then
    echo "Installing bash_profile hook..."
    echo "
# trick's bash_profile script
source ~/.bash_profile_trick_skel" >> $HOME/.bash_profile
fi

echo "Done."
