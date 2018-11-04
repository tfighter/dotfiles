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
#	xstow
    cowsay
    fortune
    neovim
    gpg
	man
#    most
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
#for package in "${apt_packages[@]}"; do
		sudo apt install -y "${apt_packages[@]}"
#done;

echo -e "\nre-initializing vim-plugins...\n"

# cd to vim bundle directory for plugin installations
pushd vim/.vim/bundle > /dev/null

# git clones all specified plugins
for plugin in "${vim_plugins[@]}"; do
		plugin_dir=$(echo "$plugin" | awk -F'\/' '{ print $2 }')

		# only if plugin folder is empty. 
		# SIDENOTE: is this necessary? Why not just git clone them w/o the isEmpty check?
		#if [ ! "$(ls -A $plugin_dir)" ]; then
				echo -e "\ngit clone https://github.com/$plugin"
				git clone "https://github.com/$plugin"
		#fi;
done;
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

echo -e "\nDone!"

