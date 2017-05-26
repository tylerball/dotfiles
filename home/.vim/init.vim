syntax on

let mapleader = ","
let maplocalleader = "\\"

let g:python3_host_prog = $HOME."/.vim/virtualenv/bin/python3"

call plug#begin('~/.vim/bundle')

" Syntaxes
Plug 'w0rp/ale'
Plug 'sorin-ionescu/python.vim', { 'for': 'python' }
Plug 'othree/html5.vim'
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'isRuslan/vim-es6', { 'for': 'javascript' }
Plug 'avakhov/vim-yaml', { 'for': 'yaml' }
Plug 'mtscout6/vim-cjsx', { 'for': 'jsx' }
Plug 'elmcast/elm-vim', { 'for': 'elm' }
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }

" Completion
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'mhartington/nvim-typescript', { 'for': 'typescript' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'yarn global add tern' }

" Undo/paste
Plug 'sjl/gundo.vim'

" Files
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'djoshea/vim-autoread'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'

"version control
Plug 'lambdalisue/gina.vim'
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
Plug 'michaeljsmith/vim-indent-object'

" Testing
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'janko-m/vim-test'

" UI
if system('uname') == 'Darwin\n'
  Plug 'powerline/fonts', { 'do': './install.sh' }
endif
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'justinmk/vim-sneak'
Plug 'myusuf3/numbers.vim'
Plug 'tpope/vim-obsession'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'christoomey/vim-tmux-navigator'

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

" Fugitive
nnoremap <leader>gs :Gina status<cr>
nnoremap <leader>gd :Gina compare :<cr>
nnoremap <leader>ga :Gina add %<cr>
nnoremap <leader>gc :Gina commit
nnoremap <leader>gb :Gina blame :<cr>
nnoremap <leader>gl :Gina log :<cr>
nnoremap <leader>gb :Gina browse :%<CR>
vnoremap <leader>gb :Gina browse :%<CR>

" vim-vinegar
map <localleader>f <Plug>VinegarVerticalSplitUp

" Clam
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>

" gundo.vim shortcut
nnoremap <F5> :GundoToggle<CR>

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
