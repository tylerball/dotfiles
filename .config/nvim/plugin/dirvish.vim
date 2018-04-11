let g:dirvish_mode = ':sort | sort ,^.*/,'
nmap - :Dirvish %<cr>
nmap <localleader>f :vsplit<CR>:Dirvish %<CR>
augroup dirvish_config
  autocmd!
  autocmd FileType dirvish silent! unmap <buffer> <C-p>
  autocmd FileType dirvish nmap e :e :<Tab>
augroup END
