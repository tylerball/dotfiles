nnoremap <C-p> :Telescope find_files<cr>
nnoremap <leader>a :Telescope live_grep<cr>
nnoremap <C-b> :Telescope buffers<CR>

function! s:build_quickfix_list(lines)
   call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
   copen
   cc
 endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'botright vnew' }

" https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2#.7tq6fyynl
command! -bang -nargs=* -complete=dir Rg call Rg(<q-args>)

function! Rg(args)
  let l:escaped_args = escape(a:args, '|#%')
  call fzf#vim#grep('rg --column --line-number --no-heading '
        \ .'--smart-case --hidden --glob "!.git/*" --color=always "'.l:escaped_args.'"| tr -d "\017"',
        \ 0, 0)
endfunction

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
