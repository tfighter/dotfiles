#!/bin/bash

dfiles=$(git rev-parse --show-toplevel)/config

apt_packages=(
curl
wget
terminator
xterm
vim
gnupg
mandb
bash_completion
)


# "magic" one liner to symlink all dotfiles
pushd $dfiles
ln --force -Lrsb .* $HOME/
popd


# download apt packages if not present
for pkg in "${apt_packages[@]}"; do
    if [[ "$(which apt)" ]]; then 
        sudo apt install -y "$pkg"
    elif [[ "$(which crew)" ]]; then 
        yes | crew install "$pkg"
    else
        echo -e "[ERROR] Can't locate which package repo to use.\n"
        exit -1;
    fi;
done

echo -e "\nRe-initializing vim-plugins...\n"


echo "Sourcing $SHELL"
case "$SHELL" in
    "$(which bash)")
        source $HOME/.bashrc
        ;;
    "$(which zsh)")
        source $HOME/.zshrc
        ;;
    *)
        echo -e "[ERROR] Can't locate proper shell file to source from\n"
        exit -1
esac

echo -e "\nDone!"

