function! s:Light()
  set background=light
  colorscheme base16-default
endfunction
command! -range=% Light call <SID>Light()

function! s:Dark()
  set background=dark
  colorscheme base16-default
endfunction
command! -range=% Dark call <SID>Dark()
