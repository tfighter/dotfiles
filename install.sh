#!/bin/bash

dfiles=$("git rev-parse --show-toplevel")/config

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
ln --force -rsb .* $HOME/
popd


# download apt packages if not present
for pkg in "${apt_packages[@]}"; do
    if [[ "$(which apt)" ]]; then 
        sudo apt install -y "$pkg"
    elif [[ "$(which crew)" ]]; then 
        yes | crew install "$pkg"
    else
        echo "[ERROR] Can't locate which package repo to use."
        exit -1;
    fi;
done

echo "========    Re-initializing vim-plugins..."


echo "Sourcing $SHELL"
case "$SHELL" in
    "$(which bash)")
        source $HOME/.bashrc
        ;;
    "$(which zsh)")
        source $HOME/.zshrc
        ;;
    *)
        echo "[ERROR] Can't locate proper shell file to source from"
        exit -1
esac

echo "========    Done!"

