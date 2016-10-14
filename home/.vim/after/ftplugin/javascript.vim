setlocal foldmethod=marker
setlocal foldmarker={,}
setlocal omnifunc=javascriptcomplete#CompleteJS
setlocal commentstring=//\ %s

let test#javascript#mocha#executable = 'bundle exec teaspoon'
let g:jsx_ext_required = 0
