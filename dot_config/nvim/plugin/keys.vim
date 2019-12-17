" sane movement
noremap j gj
noremap k gk

" ^ and $ are hard to type and are in the opposite direction of what they do
nmap H ^
nmap L $
vmap H ^
vmap L $

" <tab is easier than %
nmap <tab> %
vmap <tab> %

" keep selection when indenting
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" diffs
nnoremap <leader>dp :diffput<cr>
nnoremap <leader>dg :diffget<cr>
nnoremap <leader>dt :diffthis<cr>

" select pasted text
nnoremap gp V`]

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

nmap Q <nop>

cnoremap <C-a> <Home>

vnoremap π "_dP

" paste overtop of visually highlighted text without deleting/yanking
nnoremap d "_d
vnoremap d "_d
nnoremap D "_D
vnoremap D "_D
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C
vnoremap p "_dP
