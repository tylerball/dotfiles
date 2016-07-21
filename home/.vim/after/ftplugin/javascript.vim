setlocal foldmethod=marker
setlocal foldmarker={,}
setlocal omnifunc=javascriptcomplete#CompleteJS

let test#javascript#mocha#executable = 'bundle exec teaspoon'
let g:syntastic_javascript_checkers =['eslint', 'jshint']
let g:jsx_ext_required = 0
