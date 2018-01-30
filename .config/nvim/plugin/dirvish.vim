let g:dirvish_mode = ':sort | sort ,^.*/,'
nmap - :Dirvish %<cr>
nmap <localleader>f :vsplit<CR>:Dirvish %<CR>
