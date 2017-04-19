" Fugitive
nnoremap <leader>gs :Gina status<cr>
nnoremap <leader>gd :Gina compare :<cr>
nnoremap <leader>ga :Gina add %<cr>
nnoremap <leader>gc :Gina commit
nnoremap <leader>gb :Gina blame :<cr>
nnoremap <leader>gl :Gina log :<cr>
nnoremap <leader>gb :Gina browse :%<CR>
vnoremap <leader>gb :Gina browse :%<CR>

command! Gread !git checkout -- %
