setlocal foldmethod=marker
setlocal foldmarker={,}

autocmd InsertEnter * setlocal iskeyword+=-
autocmd InsertLeave * setlocal iskeyword-=-
