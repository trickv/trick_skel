#!/usr/bin/env bash


INSTALL_DOTFILES=".screenrc .vimrc .bash_profile_trick_skel .colordiffrc"
INSTALL_BINFILES="colordiff mk mkins mkunins mkcln skelinfo"

#####

echo "Installing in `whoami`@`hostname`..."

mkdir -p $HOME/tmp/trick_skel_backup

echo -n "Backing up "
for cur in $INSTALL_DOTFILES; do
    pushd $HOME > /dev/null
    echo -n "$cur, "
    cp $cur $HOME/tmp/trick_skel_backup
    popd > /dev/null
done
echo

tar cfj $HOME/tmp/trick_skel_backup-`date -u "+%Y%m%d-%H%M%S"`.tar.bz2 $HOME/tmp/trick_skel_backup > /dev/null 2>&1 | egrep 'Removing leading'
rm -rf $HOME/tmp/trick_skel_backup

# Delete old backups
find $HOME/tmp/trick_skel_backup* -ctime +7 -delete

echo -n "Installing "
for cur in $INSTALL_DOTFILES; do
    echo -n "$cur, "
    cp skel/$cur $HOME/$cur
done
echo

echo -n "Installing bin files "
for cur in $INSTALL_BINFILES; do
    echo -n "$cur, "
    cp skel/bin/$cur $HOME/bin/$cur
done
echo

grep bash_profile_trick_skel $HOME/.bash_profile &> /dev/null
if [ $? -ne 0 ]; then
    echo "Installing bash_profile hook..."
    echo "
# trick's bash_profile script
source ~/.bash_profile_trick_skel" >> $HOME/.bash_profile
fi

echo "Installing .trick_skel_info{,.xml}..."
which svn &> /dev/null
if [ $? -eq 0 ]; then
    `which svn` info > ~/.trick_skel_info
    `which svn` info --xml > ~/.trick_skel_info.xml
else
    echo "svn not available, skelinfo will not be available"
fi
date -u > ~/.trick_skel_install_date

echo "Done."

