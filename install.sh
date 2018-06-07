#!/bin/bash

# potential dotfiles @$HOME that might get overwritten
to_backup=(
    .bashrc
)

# backup important dotfile(s) if it's not a symlink
for dot_file in "${to_backup[@]}"; do
    if [[ ! -L "~/$dot_file" ]]; then
        mv "~/$dot_file" "~/$dot_file.bak"
    fi;
done;


# download stow if not installed
if ! stow --version >/dev/null 2>&1 ; then
    echo -e "stow not detected. Running \"sudo apt-get install stow\"..."
    sudo apt-get install stow
fi

echo -e "Synchronizing stowed packages...\n"

# initialize all dotfiles and their respective symlinks
for dot_file in $(ls -dA  */ ); do
    echo -e "stow $dot_file"
    stow -R $dot_file
done

echo -e "\nDone!"
