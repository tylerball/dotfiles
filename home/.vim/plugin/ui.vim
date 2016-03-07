" Colors
" ------
let base16colorspace=256
set background=dark
colorscheme base16-default
hi VertSplit ctermfg=10 ctermbg=10 guifg=#282828 guibg=#282828
hi diffText   guibg=#1D3163 guifg=#7cafc2
hi diffChange guibg=#1D3163 guifg=#585858

au BufNew * call matchadd('Todo', 'TODOF')
au BufNew * call matchadd('Todo', 'TODOB')
au BufNew * call matchadd('Todo', 'TODO')
hi Todo guifg=#AC000B ctermfg=124
hi SpecialKey ctermfg=red guifg=#CA0908 gui=bold
