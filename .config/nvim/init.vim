syntax on

let mapleader = ","
let maplocalleader = "\\"

let g:python3_host_prog = $HOME."/.config/nvim/virtualenv/bin/python3"

call plug#begin('~/.config/nvim/bundle')

" Completion
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'roxma/nvim-completion-manager'
Plug 'SirVer/ultisnips'

" Syntaxes
Plug 'editorconfig/editorconfig-vim'
Plug 'w0rp/ale'
Plug 'sorin-ionescu/python.vim', { 'for': 'python' }
Plug 'othree/html5.vim'
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
Plug 'isRuslan/vim-es6', { 'for': 'javascript' }
Plug 'avakhov/vim-yaml', { 'for': 'yaml' }
Plug 'mtscout6/vim-cjsx', { 'for': 'jsx' }
Plug 'elmcast/elm-vim', { 'for': 'elm' }
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'vim-ruby/vim-ruby'
Plug 'jparise/vim-graphql'

" Undo/paste
Plug 'sjl/gundo.vim'

" Files
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'djoshea/vim-autoread'
Plug 'tpope/vim-eunuch'
Plug 'justinmk/vim-dirvish'

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
Plug 'michaeljsmith/vim-indent-object'
Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-peekaboo'

" Testing
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'janko-m/vim-test'

" UI
if system('uname') == 'Darwin\n'
  Plug 'powerline/fonts', { 'do': './install.sh' }
endif
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-obsession'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'christoomey/vim-tmux-navigator'

" Utilities
if executable('pbcopy')
  Plug  'zerowidth/vim-copy-as-rtf'
endif
Plug 'itspriddle/vim-marked'
Plug 'rizzatti/dash.vim'

" color schemes
Plug 'chriskempson/base16-vim'

call plug#end()

" gundo.vim shortcut
nnoremap <F5> :GundoToggle<CR>

" Gitgutter
let g:gitgutter_on_bufenter = 0

" vim-test
nmap <silent> <localleader>t :TestNearest<CR>
nmap <silent> <localleader>T :TestFile<CR>
nmap <silent> <localleader>a :TestSuite<CR>
nmap <silent> <localleader>l :TestLast<CR>
nmap <silent> <localleader>g :TestVisit<CR>
let test#strategy = "dispatch"
