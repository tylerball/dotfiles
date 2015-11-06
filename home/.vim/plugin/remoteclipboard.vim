function! PropagatePasteBufferToOSX()
  let @n=getreg("*")
  call system('pbcopy-remote', @n)
  echo "done"
endfunction

function! PopulatePasteBufferFromOSX()
  let @+ = system('pbpaste-remote')
  echo "done"
endfunction

nnoremap <leader>6 :call PopulatePasteBufferFromOSX()<cr>
nnoremap <leader>7 :call PropagatePasteBufferToOSX()<cr>
