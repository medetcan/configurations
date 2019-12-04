
call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'wlangstroth/vim-racket'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdcommenter'
Plug 'prabirshrestha/async.vim'
Plug 'neomake/neomake'
Plug 'jez/vim-better-sml'
Plug 'valloric/youcompleteme', { 'do': './install.sh --all --clang-completer' }
call plug#end()
