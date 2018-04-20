function! s:setup_color()
  source ~/.vimrc_background
  exec "hi LineNr guibg=#" . g:base16_gui00
  exec "hi VertSplit guibg=#" . g:base16_gui00 . " guifg=#" . g:base16_gui00
  exec "hi LineNr guibg=#" . g:base16_gui00
  exec "hi GitGutterAdd guibg=#" . g:base16_gui00
  exec "hi GitGutterChange guibg=#" . g:base16_gui00
  exec "hi GitGutterDelete guibg=#" . g:base16_gui00
  exec "hi GitGutterChangeDelete guibg=#" . g:base16_gui00
  exec "hi StatusLineNC guibg=#" . g:base16_gui00
  exec "hi LightlineMiddle_normal guibg=#" . g:base16_gui00
  exec "hi LightlineMiddle_inactive guibg=#" . g:base16_gui00 . " guifg=#" . g:base16_gui04
  exec "hi LightlineLeft_normal_0 guibg=#" . g:base16_gui06
  exec "hi LightlineLeft_normal_1 guibg=#" . g:base16_gui00
  exec "hi LightlineLeft_normal_1_2 guibg=#" . g:base16_gui02
  exec "hi LightlineLeft_inactive_0 guibg=#" . g:base16_gui00 . " guifg=#" . g:base16_gui04
  exec "hi LightlineRight_normal_0 guibg=#" . g:base16_gui06
  exec "hi LightlineRight_normal_1 guibg=#" . g:base16_gui00
  exec "hi LightlineRight_normal_2 guibg=#" . g:base16_gui00
  exec "hi LightlineRight_inactive_0 guibg=#" . g:base16_gui00 . " guifg=#" . g:base16_gui04
  exec "hi LightlineRight_inactive_1 guibg=#" . g:base16_gui00 . " guifg=#" . g:base16_gui04
  exec "hi NonText guifg=#" . g:base16_gui00
  hi SpecialKey ctermfg=red guifg=#CA0908 gui=bold
  hi diffText   guibg=#1D3163 guifg=#7cafc2
  hi diffChange guibg=#1D3163 guifg=#585858
  exec "hi ColorColumn guibg=" . color#lighten('#' . g:base16_gui00, '0.2')
endfunction

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  call s:setup_color()
  autocmd FocusGained * nested call s:setup_color()
endif
