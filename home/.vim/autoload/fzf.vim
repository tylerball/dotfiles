nnoremap <leader>a :Rg<Space>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-f> :Lines<CR>
nnoremap <leader>m :History<CR>
nnoremap <C-p> :FZF<cr>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'botright vnew' }

" https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2#.7tq6fyynl
command! -bang -nargs=* Rg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --fixed-strings "
  \ ."--ignore-case --hidden --glob '!.git/*' --color=always ".shellescape(<q-args>).'| tr -d "\017"',
  \ 0, <bang>0)
