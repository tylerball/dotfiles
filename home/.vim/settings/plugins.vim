call plug#begin('~/.vim/bundle')

" Dependencies
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'mattn/webapi-vim'

" Syntaxes
Plug 'scrooloose/syntastic'
Plug 'sorin-ionescu/python.vim', { 'for': 'python' }
Plug 'othree/html5.vim'
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'isRuslan/vim-es6', { 'for': 'javascript' }
Plug 'avakhov/vim-yaml', { 'for': 'yaml' }
Plug 'mtscout6/vim-cjsx', { 'for': 'jsx' }
Plug 'mxw/vim-jsx', { 'for': 'jsx' }
Plug 'elmcast/elm-vim', { 'for': 'elm' }

" Completion
Plug 'garbas/vim-snipmate'
if has('python')
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --tern-completer' }
end

" Undo/paste
Plug 'sjl/gundo.vim'

" Files
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/unite.vim'
Plug 'djoshea/vim-autoread'

"version control
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'sjl/splice.vim'
Plug 'airblade/vim-gitgutter'

" Text manipulation
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/nerdcommenter'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-jdaddy'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'Shougo/neoyank.vim'

" Testing
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'

" UI
if system('uname') == 'Darwin\n'
  Plug 'powerline/fonts', { 'do': './install.sh' }
endif
Plug 'bling/vim-airline'
Plug 'Lokaltog/vim-easymotion'
Plug 'myusuf3/numbers.vim'
Plug 'tpope/vim-obsession'
Plug 'ConradIrwin/vim-bracketed-paste'

" Utilities
Plug 'sjl/clam.vim'
Plug 'mattn/gist-vim'
if executable('pbcopy')
  Plug  'zerowidth/vim-copy-as-rtf'
endif
Plug 'itspriddle/vim-marked', { 'for': 'markdown' }

" color schemes
Plug 'tylerball/vim-hypertint'
Plug 'chriskempson/base16-vim'

call plug#end()

" Vim plugin settings

" Fugitive
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gc :Gcommit
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gl :Glog<cr>:copen<cr>

" nerdtree
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 40
let NERDTreeShowHidden=1
" ignore .pyc files
let NERDTreeIgnore=['\.pyc$', '\~$']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" open nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>

map <localleader>f :NERDTreeFind<cr>

" don't open nerdtree by default
let g:nerdtree_tabs_open_on_gui_startup=0

" unite
let g:unite_source_history_yank_enable = 1
" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])
" Use the rank sorter for everything
call unite#filters#sorter_default#use(['sorter_rank'])
" Like ctrlp.vim settings.
call unite#custom#profile('default', 'context', {
\   'winheight': 15,
\   'direction': 'botright',
\ })

nnoremap <C-c> :Unite -buffer-name=yank -default-action=insert history/yank<CR>

" Snipmate
imap <C-\> <esc>a<Plug>snipMateNextOrTrigger
smap <C-\> <Plug>snipMateNextOrTrigger

" Clam
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>

" Tabularize
nnoremap <localleader>u :Tabularize /
vnoremap <localleader>u :Tabularize /

" easymotion
let g:EasyMotion_leader_key = '<Leader>'

" gundo.vim shortcut
nnoremap <F5> :GundoToggle<CR>

" nerd commenter
let g:NERDCustomDelimiters = {
    \ 'scss': { 'left': '// ' },
\ }

" splice
let g:splice_initial_mode = "grid"
let g:splice_initial_layout_grid = 1

" airline
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : '',
    \ 'i'  : '',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'VL',
    \ '' : 'VB',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }
let g:airline_section_y = ''
let g:airline_theme='dark'

" Numbers.vim
nnoremap <F3> :NumbersToggle<CR>

" Gitgutter
let g:gitgutter_on_bufenter = 0

" vim-autoread
let autoreadargs={'autoread':1}
au BufRead,BufNewFile * :silent! execute WatchForChanges("*", autoreadargs)

let g:jsx_ext_required = 0

" vim-marked
nnoremap <localleader>m :MarkedOpen!<cr>

" dispatch
nnoremap <localleader>t :Dispatch<cr>

nnoremap <localleader>w :FixWhitespace<cr>
