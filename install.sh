#!/bin/bash

# potential dotfiles @$HOME that might get overwritten
to_backup=(
    .bashrc
    .bash_logout
    .profile
    .sudo_as_admin_successful
    .zshrc
    .zsh_history
)


apt_packages=(
    terminator
    wget
    stow
    xstow
    cowsay
    fortune
    vim
    gpg
    most
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
	if [[ ! "command -v $package" > "/dev/null" ]] ; then
		echo -e "\n$package not detected. Running \"sudo apt-get install $package\"..."
		sudo apt-get install -y "$package"
	fi
done;

# git clone all plugins
echo -e "\nre-initializing vim-plugins..."
cd vim/.vim/bundle
for plugin in "${vim_plugins[@]}"; do
		plugin_dir=$(echo "$plugin" | awk -F'\/' '{ print $2 }')

		# git clones plugin if plugin folder is empty.
		if [ ! "$(ls -A $plugin_dir)" ]; then
				echo -e "\ngit clone https://github.com/$plugin"
				git clone "https://github.com/$plugin"
		fi;
done;
	

echo -e "\nSynchronizing stowed packages...\n"

# initialize all dotfiles and their respective symlinks
for dot_file in $(ls -dA  $HOME/dotfiles/*/ | awk -F'\/' '{print $5}'); do
    echo -e "stow $dot_file"
    stow -R $dot_file -d $HOME/dotfiles -t $HOME
done




echo "sourcing proper shell file: $SHELL"
case "$SHELL" in
		"$(which bash)")
				. $HOME/.bashrc
				;;
		"$(which zsh)")
				. $HOME/.zshrc
				;;
		*)

				echo -e "[ERROR] Can't locate proper shell file to source from"
				exit -1
esac

echo -e "\nDone!"

