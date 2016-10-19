" Colors
" ------
set termguicolors
let base16colorspace=256
set background=dark
let g:airline_theme='base16_default'
colorscheme base16-default-dark
hi VertSplit ctermfg=18 ctermbg=18 guifg=#282828 guibg=#282828
hi diffText   guibg=#1D3163 guifg=#7cafc2
hi diffChange guibg=#1D3163 guifg=#585858

au BufNew * call matchadd('Todo', 'TODOF')
au BufNew * call matchadd('Todo', 'TODOB')
au BufNew * call matchadd('Todo', 'TODO')
hi Todo guifg=#AC000B ctermfg=124
hi SpecialKey ctermfg=red guifg=#CA0908 gui=bold
