setlocal omnifunc=LanguageClient#complete
if executable('javascript-typescript-stdio')
  let g:LanguageClient_serverCommands.typescript = ['javascript-typescript-stdio']
endif
