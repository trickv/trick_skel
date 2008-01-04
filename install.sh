#!/usr/bin/env bash

INSTALL_DOTFILES=".screenrc .vimrc .bash_profile_trick_skel .colordiffrc .my.cnf.trick_skel"

#####

ARCHIVE_DIR=$HOME/tmp/trick_skel_archive

####

echo "Installing in `whoami`@`hostname`..."

# On a fresh home dir, ~/bin does not exist
mkdir -p $HOME/bin/trick_skel $ARCHIVE_DIR

# Archive old files
# First stuff them into a temp dir
mkdir -p $HOME/tmp/trick_skel_backup
echo -n "Archiving "
for cur in $INSTALL_DOTFILES; do
    pushd $HOME > /dev/null
    echo -n "$cur, "
    cp $cur $HOME/tmp/trick_skel_backup
    popd > /dev/null
done
echo
# Then tar 'em up
tar cfj $ARCHIVE_DIR/archive-`date -u "+%Y%m%d-%H%M%S"`.tar.bz2 $HOME/tmp/trick_skel_backup > /dev/null 2>&1 | egrep 'Removing leading'
rm -r $HOME/tmp/trick_skel_backup
# Finally, delete old archives
find $ARCHIVE_DIR -name "archive*" -ctime +10 | xargs -n 10 rm -f

# This should be removed after 2008-01-10
find $HOME/tmp -name "trick_skel_backup*" -ctime +7 | xargs -n 10 rm -f

# Install ~/.trick_skel directory
rm -rf $HOME/.trick_skel
cp -R skel/.trick_skel $HOME

# Install .dotfiles
echo -n "Installing: "
for cur in $INSTALL_DOTFILES; do
    echo -n "$cur, "
    cp skel/$cur $HOME/$cur
done
echo

# Install scripts into ~/bin
echo -n "Installing bin files and wiping out any conflicts in ~/bin: "
rm -f $HOME/bin/trick_skel/*
for cur in `ls skel/bin/`; do
    echo -n "$cur, "
    rm -f $HOME/bin/$cur
    cp skel/bin/$cur $HOME/bin/trick_skel/$cur
done
echo

# If this is a new installation, add a call to the bash_profile
grep bash_profile_trick_skel $HOME/.bash_profile &> /dev/null
if [ $? -ne 0 ]; then
    echo "Installing bash_profile hook..."
    echo "
# trick's bash_profile script
source ~/.bash_profile_trick_skel" >> $HOME/.bash_profile
fi

# MySQL .my.cnf file generation [magic]
if [ -f $HOME/.my.cnf.local ]; then
    cat $HOME/.my.cnf.local > ~/.my.cnf
    echo >> ~/.my.cnf
    cat $HOME/.my.cnf.trick_skel >> ~/.my.cnf
fi

# Install info on this version of trick_skel
# TODO: remove the following line after it has propogated (2008-01-10)
rm -f $HOME/.trick_skel{_info,_info.xml,_install_date}
mkdir -p $HOME/.trick_skel/info
svn info &> /dev/null
if [ $? -eq 0 ]; then
    # we have svn and it can read the properties
    svn info --xml > $HOME/.trick_skel/info/xml
    svn info > $HOME/.trick_skel/info/txt
    if [ "`hostname -s`" = "atlas" ]; then
        rm -rf svn-info
        mkdir -p svn-info
        cp $HOME/.trick_skel/info/* svn-info/
    fi
else
    # we don't have svn; see if atlas has already written this info for us
    if [ -d svn-info ]; then
        # we have infos, copy in place
        cp svn-info/* $HOME/.trick_skel/info/
    fi
fi

date -u > ~/.trick_skel/info/install_date

# install optional scripts depending on conditionals
case "`hostname -s`" in atlas|mc)
    rm -f $HOME/bin/view
    cp optional/view $HOME/bin/trick_skel/

    rm -f $HOME/bin/myterm_remote
    cp optional/myterm_remote $HOME/bin/trick_skel/

    rm -f $HOME/bin/select-{color,font}
    cp optional/select-{color,font} $HOME/bin/trick_skel/

    rm -f $HOME/bin/gnome-help
    ln -s /bin/true $HOME/bin/trick_skel/gnome-help
esac

if [ "`uname`" = "Linux" ]; then
    rm -f $HOME/bin/lside
    cp optional/lside $HOME/bin/trick_skel/
fi

# Viola!
echo "Done."
