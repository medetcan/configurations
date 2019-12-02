set number
set spell
set tabstop=4
set shiftwidth=4
set expandtab
set nobackup
set noswapfile
set nowritebackup

syntax on

nnoremap <CR> :noh<CR><CR>
map <C-n> :NERDTreeToggle<CR>

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
Plug 'valloric/youcompleteme'
call plug#end()

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_racket_racket_checker = 1
let g:NERDSpaceDelims = 1


" neomake report errors after 500 miliseconds delay 
" normal mode, buffer read, buffer write, insert mode in all of those state
" neomake will be called
" Should not directly set from here
call neomake#configure#automake('nrwi', 500)
