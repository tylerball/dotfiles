let g:dirvish_mode = ':sort | sort ,^.*/,'
nmap - :Dirvish %<cr>
nmap <leader>f :vsplit<CR>:Dirvish %<CR>
augroup dirvish_config
  autocmd!
  autocmd FileType dirvish silent! unmap <buffer> <C-p>
  autocmd FileType dirvish nmap e :e <C-R>=expand('%')<CR>
augroup END
