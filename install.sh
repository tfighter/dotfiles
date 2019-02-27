#!/bin/bash

DOTFILE=$PWD

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

vim_plugins=(
  rafi/awesome-vim-colorschemes
  yuttie/comfortable-motion.vim
  scrooloose/nerdtree
)


# "magic" one liner to symlink all dotfiles
ln --force -rsbv $DOTFILE/config/.* $HOME/

# git clones all specified plugins
pushd $HOME/.vim/bundle/
for plugin in "${vim_plugins[@]}"; do
  git clone "https://github.com/$plugin"
done
popd


# download apt packages if not present
for pkg in "${apt_packages[@]}"; do
  if [[ "$(which apt-get)" ]];
    then sudo apt-get install -y "$pkg"
  elif [[ "$(which crew)" ]];
    then crew install "$pkg"
  else
    echo "[ERROR] Can't locate which package repo to use."
    exit -1;
  fi;
done

echo "========    Re-initializing vim-plugins..."


echo "Sourcing .$SHELL"
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

#initializing man pages & set $PAGER
export PAGER="$(which less)"

echo "========    Done!"

