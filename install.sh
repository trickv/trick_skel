#!/bin/sh

mkdir -p ~/tmp/trickv_skel_backup

for cur in $INSTALL_DOTFILES; do
    pushd ~/
    echo "Backing up $cur..."
    cp $cur ~/tmp/trickv_skel_backup
    popd
done

tar cfj ~/tmp/trickv_skel_backup-`date +%Y%m%d-%H%M%S -u` ~/tmp/trickv_skel_backup
rm -rf ~/tmp/trickv_skel_backup

for cur in $INSTALL_DOTFILES; do
    echo "Installing $cur..."
    cp $cur ~/${cur}
done

grep bash_profile_trickv_skel $HOME/.bash_profile &> /dev/null
if [ $? -ne 0 ]; then
    echo "Installing bash_profile hook..."
    echo "
# trickv's bash_profile script
source ~/.bash_profile_trickv_skel" >> ~/.bash_profile
fi

echo "Done."
