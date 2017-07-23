setlocal foldmethod=marker
setlocal foldmarker={,}
setlocal omnifunc=csscomplete#CompleteCSS

autocmd InsertEnter * setlocal iskeyword+=-
autocmd InsertLeave * setlocal iskeyword-=-
