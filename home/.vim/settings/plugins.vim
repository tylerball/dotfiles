call plug#begin('~/.vim/bundle')

" Syntaxes
Plug 'neomake/neomake'
Plug 'sorin-ionescu/python.vim', { 'for': 'python' }
Plug 'othree/html5.vim'
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'isRuslan/vim-es6', { 'for': 'javascript' }
Plug 'avakhov/vim-yaml', { 'for': 'yaml' }
Plug 'mtscout6/vim-cjsx', { 'for': 'jsx' }
Plug 'elmcast/elm-vim', { 'for': 'elm' }

" Completion
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
if has('python')
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --tern-completer' }
end

" Undo/paste
Plug 'sjl/gundo.vim'

" Files
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'djoshea/vim-autoread'
Plug 'tpope/vim-vinegar'

"version control
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

" Text manipulation
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'

" Testing
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'janko-m/vim-test'

" UI
if system('uname') == 'Darwin\n'
  Plug 'powerline/fonts', { 'do': './install.sh' }
endif
Plug 'bling/vim-airline'
Plug 'justinmk/vim-sneak'
Plug 'myusuf3/numbers.vim'
Plug 'tpope/vim-obsession'
Plug 'ConradIrwin/vim-bracketed-paste'

" Utilities
Plug 'sjl/clam.vim'
if executable('pbcopy')
  Plug  'zerowidth/vim-copy-as-rtf'
endif
Plug 'itspriddle/vim-marked'

" color schemes
Plug 'tylerball/vim-hypertint'
Plug 'chriskempson/base16-vim'

call plug#end()

" Vim plugin settings
"
" neomake
autocmd! BufWritePost * Neomake

" Fugitive
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gc :Gcommit
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gl :Glog<cr>:copen<cr>

" vim-vinegar
map <localleader>f <Plug>VinegarVerticalSplitUp

" Clam
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>

" gundo.vim shortcut
nnoremap <F5> :GundoToggle<CR>

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

" vim-test
nmap <silent> <localleader>t :TestNearest<CR>
nmap <silent> <localleader>T :TestFile<CR>
nmap <silent> <localleader>a :TestSuite<CR>
nmap <silent> <localleader>l :TestLast<CR>
nmap <silent> <localleader>g :TestVisit<CR>
let test#strategy = "dispatch"

" vim-trailing-whitespace
nnoremap <localleader>w :FixWhitespace<cr>

" ultisnips
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" obsession
function! s:setup_obsession()
  if '.git/' =~ join(argv()) " don't start/source sessions for git stuff
    if filereadable("Session.vim")
      source Session.vim
    else
      Obsession .
    endif
  end
endfunction
autocmd VimEnter * nested call s:setup_obsession()
