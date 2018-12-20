#!/bin/bash

apt_packages=(
  #wget #DEPRECATED on crosh
  terminator
  stow
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

# unstow first
stow -D */

# backup important dotfile(s) if it's not a symlink
for dir in */; do
  pushd $dir > /dev/null
  for dfile in .*; do
    if [[ ! -e "$HOME/.$dfile" ]]; then
      mv "$HOME/$dfile" "$HOME/$dfile.bak" &> /dev/null
    fi; 
  done
  popd > /dev/null
done

# backup preexisting dotfiles before the stow command auto installs this dotfile repo
for d_file in "${to_backup[@]}"; do
  if [[ ! -L "$HOME/$d_file" ]]; then
    echo "Backed up $d_file to $d_file.bak"
    mv "$HOME/$d_file" "$HOME/$d_file.bak"
  fi;
done

# download apt packages if not present
for pkg in "${apt_packages[@]}"; do
  if [[ "$(which apt)" ]];
    then sudo apt install -y "$pkg"
  elif [[ "$(which crew)" ]];
    then crew install "$pkg"
  else
    echo "[ERROR] Can't locate which package repo to use."
    exit -1;
  fi;
done

echo "========    Re-initializing vim-plugins..."

# git clones all specified plugins
pushd vim/.vim/bundle > /dev/null
for plugin in "${vim_plugins[@]}"; do
  git clone "https://github.com/$plugin" &> /dev/null
done
popd > /dev/null


# the important part here: symlink all packages
echo "========    Synchronizing stowed packages..."
stow -Sv */

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
mandb -pst

echo "========    Done!"


