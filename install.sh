#!/bin/bash

# potential dotfiles @$HOME that might get overwritten
to_backup=(
    .bashrc
    .bash_logout
    .profile
    .sudo_as_admin_successful
)


apt_packages=(
    stow
    xstow
    cowsay
    fortune
    vim
    gpg
)

vim_plugins=(
	rafi/awesome-vim-colorschemes
	yuttie/comfortable-motion.vim
)

# backup important dotfile(s) if it's not a symlink
for dot_file in "${to_backup[@]}"; do
    if [[ ! -L "$HOME/$dot_file" ]]; then
	echo "Backed up $dot_file to $dot_file.bak"
        mv "$HOME/$dot_file" "$HOME/$dot_file.bak"
    fi;
done;


# download apt packages if not present
for package in "${apt_packages[@]}"; do
	if [[  "command -v $package" > "/dev/null" ]] ; then
		echo -e "\n$package not detected. Running \"sudo apt-get install $package\"..."
		yes | sudo apt-get install "$package"
	fi
done;

# git clone all plugins
echo -e "\nre-initializing vim-plugins..."
cd vim/.vim/bundle
for plugin in "${vim_plugins[@]}"; do
	echo -e "\ngit clone https://github.com/$plugin"
	git clone "https://github.com/$plugin"
done;
	

echo -e "\nSynchronizing stowed packages...\n"

# initialize all dotfiles and their respective symlinks
for dot_file in $(ls -dA  $HOME/dotfiles/*/ | awk -F'\/' '{print $5}'); do
    echo -e "stow $dot_file"
    stow -R $dot_file -d $HOME/dotfiles -t $HOME
done


echo -e "\nDone!"

source $HOME/.bashrc

