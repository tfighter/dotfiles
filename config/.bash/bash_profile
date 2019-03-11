bash_profiles=( .git-completion.bash .bashrc) 

for profile in "${bash_profiles[@]}"
do
    if [[ -f "$HOME/$profile" || -L "$HOME/$profile" ]]; then
        . "$HOME/$profile"
    fi
done
