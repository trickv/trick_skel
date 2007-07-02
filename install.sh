#!/bin/sh

INSTALL_DOTFILES=".screenrc .vimrc .bash_profile_trick_skel"

#####

mkdir -p ~/tmp/trick_skel_backup

for cur in $INSTALL_DOTFILES; do
    pushd ~/ > /dev/null
    echo "Backing up $cur..."
    cp $cur ~/tmp/trick_skel_backup
    popd > /dev/null
done

tar cfj ~/tmp/trick_skel_backup-`date +%Y%m%d-%H%M%S -u`.tar.bz2 ~/tmp/trick_skel_backup > /dev/null
rm -rf ~/tmp/trick_skel_backup

for cur in $INSTALL_DOTFILES; do
    echo "Installing $cur..."
    cp skel/$cur ~/$cur
done

grep bash_profile_trick_skel $HOME/.bash_profile &> /dev/null
if [ $? -ne 0 ]; then
    echo "Installing bash_profile hook..."
    echo "
# trick's bash_profile script
source ~/.bash_profile_trick_skel" >> ~/.bash_profile
fi

echo "Done."
