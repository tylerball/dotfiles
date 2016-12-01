function! s:setup_color()
  source ~/.vimrc_background
  hi VertSplit ctermfg=18 ctermbg=18 guifg=#282828 guibg=#282828
  hi diffText   guibg=#1D3163 guifg=#7cafc2
  hi diffChange guibg=#1D3163 guifg=#585858
endfunction

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  call s:setup_color()
  autocmd FocusGained * nested call s:setup_color()
endif
