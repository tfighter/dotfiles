#!/bin/bash

apt_packages=(
#terminator
wget
stow
neovim
gnupg
mandb
fish
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

for dot_file in "${to_backup[@]}"; do
  if [[ ! -L "$HOME/$dot_file" ]]; then
    echo "Backed up $dot_file to $dot_file.bak"
    mv "$HOME/$dot_file" "$HOME/$dot_file.bak"
  fi;
done

# download apt packages if not present
if [[ "$(which apt)" ]];
  then sudo apt install -y "${apt_packages[@]}"
elif [[ "$(which crew)" ]];
  then crew install "${apt_packages[@]}"
else exit -1; fi

echo -e "\nRe-initializing vim-plugins...\n"

# git clones all specified plugins
pushd vim/.vim/bundle > /dev/null
for plugin in "${vim_plugins[@]}"; do
  git clone "https://github.com/$plugin" &> /dev/null
done
popd > /dev/null


# the important part here: symlink all packages
echo -e "\nSynchronizing stowed packages...\n"
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

    echo -e "[ERROR] Can't locate proper shell file to source from"
    exit -1
esac

echo "Setting default shell to fish"
chsh -s "/bin/fish"

echo -e "\nDone!"


