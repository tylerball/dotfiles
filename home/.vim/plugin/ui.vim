" Colors
" ------
set background=dark
colorscheme hypertint

au BufNew * call matchadd('Todo', 'TODOF')
au BufNew * call matchadd('Todo', 'TODOB')
au BufNew * call matchadd('Todo', 'TODO')
hi Todo guifg=AC000B ctermfg=124

hi NonText ctermfg=red guifg=#CA0908 gui=bold
hi SpecialKey ctermfg=red guifg=#CA0908 gui=bold
