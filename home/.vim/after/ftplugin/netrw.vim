nmap <buffer> <c-x> .split<CR>
nmap <buffer> <c-v> .vsplit<CR>
nnoremap <buffer> a :<C-U> <C-R>=<SID>fnameescape(b:netrw_curdir)<CR>/<Home>edit<End>

function! s:fnameescape(file) abort
  if exists('*fnameescape')
    return fnameescape(a:file)
  else
    return escape(a:file," \t\n*?[{`$\\%#'\"|!<")
  endif
endfunction
