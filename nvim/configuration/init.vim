source ~/.config/nvim/config/general.vim
source ~/.config/nvim/config/plugins.vim
source ~/.config/nvim/config/keymappings.vim

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
