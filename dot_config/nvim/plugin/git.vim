" Fugitive
nnoremap <leader>gs :Neogit kind=split_below_all<cr>
nnoremap <leader>gd :DiffviewOpen<cr>
nnoremap <leader>ga :silent !git add %:p<cr>
nnoremap <leader>gc :Neogit commit<cr>
nnoremap <leader>gl :Neogit log --% l<cr>

autocmd FileType diffview nmap <buffer> q :DiffviewClose<CR>
