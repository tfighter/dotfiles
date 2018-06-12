source $HOME/.vim/pathogen.vim
source $HOME/.vim/personal_settings.vim

nnoremap "*p :r !cat /home/av8t8r/.crouton-clipboard/data.txt<CR>
vnoremap "*y :'<,'>w! /home/av8t8r/.crouton-clipboard/data.txt<CR>
