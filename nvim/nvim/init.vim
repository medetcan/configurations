source ~/.config/nvim/config/plugins.vim
source ~/.config/nvim/config/general.vim
source ~/.config/nvim/config/keymappings.vim
source ~/.config/nvim/config/appearance.vim

let g:NERDSpaceDelims = 1

" neomake report errors after 500 miliseconds delay 
" normal mode, buffer read, buffer write, insert mode in all of those state
" neomake will be called
" Should not directly set from here
call neomake#configure#automake('nrwi', 500)
