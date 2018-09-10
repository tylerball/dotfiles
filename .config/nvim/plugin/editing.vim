set expandtab
set tabstop=2
set shiftwidth=2
set sts=2            "" number of spaces deleted when you hit <bs>
set textwidth=79
set undofile
set autowriteall
set wildmode=list:longest
set wildignore+=.git,.svn,*.jpg,*.gif,*.png,*.jpeg,*.DS_Store,*.pyc

nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" Don't automatically insert comments after single line comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
setlocal comments-=://
setlocal comments+=f://

" Open a Quickfix window for the last search.
nnoremap <localleader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Visual Mode */# from Scrooloose
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

" clear search
noremap <leader>n :noh<cr>

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

set formatoptions=clt " see http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table

set dictionary=/usr/share/dict/words

" vim-trailing-whitespace
nnoremap <localleader>w :FixWhitespace<cr>

" vim-autoread
let autoreadargs={'autoread':1}
au BufRead,BufNewFile * :silent! execute WatchForChanges("*", autoreadargs)

let g:ale_linters = {
\   'graphql': ['prettier'],
\}

let g:ale_fixers = {
\   'typescript': [
\       'prettier',
\   ],
\}

nmap <localleader>a :ALEDetail<cr>
nmap <localleader>F :ALEFix<cr>

let test#custom_runners = {'typescript': ['Dev']}
