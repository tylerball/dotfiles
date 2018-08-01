setlocal commentstring=//\ %s

let test#javascript#runner = 'Teaspoon'
let g:jsx_ext_required = 0

if executable('javascript-typescript-stdio')
  let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
endif
