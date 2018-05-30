#!/bin/bash

# backups current dotfiles in home
mv .bash_history .bash_history.bak
mv .bash_logout .bash_history.bak
mv .bashrc .bashrc.bak


# download stow if not installed
if stow  ; then
    sudo apt-get install stow
    echo -e "stow is now installed. Moving on to syncing with GitHub."
fi

# initialize all dotfiles and their respective symlinks
for DOTFILE in $(ls -dA  * ); do
    stow $DOTFILE
done
