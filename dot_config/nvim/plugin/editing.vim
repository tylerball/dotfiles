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

let g:ale_linters = {
\   'graphql': ['prettier'],
\}

let g:ale_fixers = {
\   'typescript': [
\       'prettier',
\   ],
\}

let test#custom_runners = {'typescript': ['Dev']}

let g:notes_directories = [ $HOME . '/Library/Mobile Documents/com~apple~CloudDocs/notes' ]
let g:notes_suffix = '.md'

let g:nv_search_paths = [ $HOME . '/Library/Mobile Documents/com~apple~CloudDocs/notes' ]
let g:nv_ignore_pattern = ['*.vim']
let g:nv_preview_direction = 'down'
let g:nv_window_command = 'aboveleft'

command! -nargs=0 Prettier :CocCommand prettier.formatFile

xmap <localleader>f  <Plug>(coc-format-selected)
nmap <localleader>f  <Plug>(coc-format-selected)
