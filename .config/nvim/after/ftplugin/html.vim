setlocal textwidth=0
" include underscores in words
setlocal iskeyword-=_
setlocal foldmethod=indent

" delete an attribute when here: |class=
nmap <localleader>d d2f"<left>x<right>

imap <c-_> <C-X><C-O>

setlocal foldmethod=indent

setlocal omnifunc=htmlcomplete#CompleteTags
