set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" Dependencies
NeoBundle 'MarcWeber/vim-addon-mw-utils.git'
NeoBundle 'tomtom/tlib_vim.git'
NeoBundle 'mattn/webapi-vim.git'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\    },
\ }

" Syntaxes
NeoBundle 'scrooloose/syntastic.git'
NeoBundle 'sorin-ionescu/python.vim.git'
NeoBundle 'othree/html5.vim.git'
NeoBundle 'kchmck/vim-coffee-script.git'
NeoBundle 'pangloss/vim-javascript.git'
NeoBundle 'isRuslan/vim-es6.git'
NeoBundle 'tpope/vim-liquid.git'
NeoBundle 'avakhov/vim-yaml.git'
NeoBundle 'tpope/vim-rails.git'
NeoBundle 'mtscout6/vim-cjsx'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'lambdatoast/elm.vim'

" Completion
NeoBundle 'garbas/vim-snipmate.git'
if has('python')
  NeoBundle 'Valloric/YouCompleteMe', {
  \ 'build' : {
  \     'mac' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
  \     'unix' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
  \    }
  \ }
end

" Undo/paste
NeoBundle 'sjl/gundo.vim.git'

" Files
NeoBundle 'junegunn/fzf'
NeoBundle 'scrooloose/nerdtree.git'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'djoshea/vim-autoread'

"version control
NeoBundle 'tpope/vim-fugitive.git'
NeoBundle 'sjl/splice.vim.git'
NeoBundle 'airblade/vim-gitgutter.git'

" Text manipulation
NeoBundle 'godlygeek/tabular.git'
NeoBundle 'tpope/vim-surround.git'
NeoBundle 'tpope/vim-repeat.git'
NeoBundle 'scrooloose/nerdcommenter.git'
NeoBundle 'mattn/emmet-vim.git'
NeoBundle 'tpope/vim-jdaddy.git'
NeoBundle 'bronson/vim-trailing-whitespace.git'
NeoBundle 'tpope/vim-endwise.git'
NeoBundle 'tpope/vim-unimpaired'

" UI
NeoBundle 'sjl/vitality.vim.git'
if system('uname') == 'Darwin\n'
  NeoBundle 'powerline/fonts', {
  \ 'build' : {
  \     'mac' : './install.sh'
  \    }
  \ }
endif
NeoBundle 'bling/vim-airline'
NeoBundle 'Lokaltog/vim-easymotion.git'
NeoBundle 'myusuf3/numbers.vim.git'
NeoBundle 'tpope/vim-obsession.git'
NeoBundle 'ConradIrwin/vim-bracketed-paste.git'

" Utilities
NeoBundle 'mileszs/ack.vim.git'
NeoBundle 'sjl/clam.vim.git'
NeoBundle 'mattn/gist-vim.git'
if executable('pbcopy')
  NeoBundle  'zerowidth/vim-copy-as-rtf.git'
endif
NeoBundle 'itspriddle/vim-marked'

" color schemes
NeoBundle 'tylerball/vim-hypertint.git'

call neobundle#end()

NeoBundleCheck
