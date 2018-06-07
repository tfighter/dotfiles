#Dotfile Introduction

Welcome to my very own dotfile github repo. I've always wanted to finally create my own repo after seeing so many other great programmers', and well... here it is. Please note that this is very preliminary work since I just started learning about dotfiles since 2 weeks ago so bear with me as you'll see very very redundant and n00b-like h4ck3r.sh scripts.


##Organization

The dotfile directory will have a separate folder for every programs that require their own .config files stored in the $HOME directory. To manage the symlinks of each dotfiles back to the root $HOME folder, I will be using *stow* to maintain consistency among each .config files as I update their organization structure in the future (as I know I inevitably will). Read more about the great and wonderful stow at https://alexpearce.me/2016/02/managing-dotfiles-with-stow/. I picked it since stow was a GNU program that will work on virtually any \*NIX platforms, thus guaranteeing the same dotfile symlinking management behaviour no matter where I ssh into (except for windows, but even that is getting better with their Linux Shell's Sub-System). 
