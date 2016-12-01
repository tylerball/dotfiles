" Interface
" ---------
:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Colors
" ------
set termguicolors
let g:airline_theme='base16_default'
au BufNew * call matchadd('Todo', 'TODOF')
au BufNew * call matchadd('Todo', 'TODOB')
au BufNew * call matchadd('Todo', 'TODO')
hi Todo guifg=#AC000B ctermfg=124
hi SpecialKey ctermfg=red guifg=#CA0908 gui=bold
