":echo "loading vim-plug"
call plug#begin('~/.vim/plugged')
Plug 'elmcast/elm-vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'eagletmt/ghcmod-vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'yuttie/comfortable-motion.vim'
Plug 'tpope/vim-surround'
""Plug 'valloric/youcompleteme'
Plug 'eagletmt/neco-ghc'
Plug 'ctrlpvim/ctrlp.vim'
""Plug 'scrooloose/syntastic'
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'
Plug 'scrooloose/nerdcommenter'
Plug 'godlygeek/tabular'
Plug 'ervandew/supertab'
""Plug 'Shougo/neocomplete'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
""Plug 'fsharp/vim-fsharp', {
""      \ 'for': 'fsharp',
""      \ 'do': 'make fsautocomplete',
""      \ }
map <C-n> :NERDTreeToggle<CR>
call plug#end()

