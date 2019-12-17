" turn a visual selection into a markdown formatted link, depends on surround.vim
vmap <localleader>l ygvS]%a(http://<esc>p)<esc>

setl ts=4 shiftwidth=4 softtabstop=4

setlocal tw=0

setlocal spell

" vim-marked
nnoremap <localleader>m :MarkedOpen<cr>

let g:vim_markdown_new_list_item_indent = 0
