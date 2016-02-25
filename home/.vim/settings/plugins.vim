call plug#begin('~/.vim/bundle')

" Dependencies
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'mattn/webapi-vim'

" Syntaxes
Plug 'scrooloose/syntastic'
Plug 'sorin-ionescu/python.vim'
Plug 'othree/html5.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'pangloss/vim-javascript'
Plug 'isRuslan/vim-es6'
Plug 'tpope/vim-liquid'
Plug 'avakhov/vim-yaml'
Plug 'mtscout6/vim-cjsx'
Plug 'mxw/vim-jsx'
Plug 'lambdatoast/elm.vim'

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
Plug 'sjl/vitality.vim'
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
Plug 'itspriddle/vim-marked'

" color schemes
Plug 'tylerball/vim-hypertint'

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

" use the_silver_searcher
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '-i --vimgrep --hidden'
  let g:unite_source_grep_recursive_opt = ''
end
nnoremap <C-b> :Unite -buffer-name=buffers buffer -start-insert<CR><Esc>GC
nnoremap <leader>a :Unite -buffer-name=grep -no-quit grep:.<CR>
nnoremap <C-c> :Unite -buffer-name=yank -default-action=insert history/yank<CR>
nnoremap <C-f> :Unite -buffer-name=search -start-insert line<CR>
nnoremap <leader>m :Unite -start-insert neomru/file<CR>
nnoremap <leader>ur :UniteResume<CR>
let g:extra_whitespace_ignored_filetypes = ['unite']
au FileType unite hi uniteSource__GrepPattern guibg=#791117, ctermbg=52

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  nmap <buffer> <ESC> <Plug>(unite_exit)
  nmap <buffer> <C-k> <c-w>k
  imap <silent><buffer><expr> <C-x> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
  " fix conflict with endwise
  silent! iunmap <C-x><CR>
endfunction

" fzf
nnoremap <C-p> :FZF<cr>
let g:fzf_launcher = "in_a_new_term_function %s"
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Syntastic
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'passive_filetypes': ['htmldjango', 'markdown', 'html'] }

let g:syntastic_python_checker_args='--ignore=E501'
let g:syntastic_javascript_checkers =['eslint', 'jshint']
let g:syntastic_scss_checkers = ['scss_lint']

let g:shopify_assets_location = substitute(system("bundle show shopify_assets"), '\n\+$', '', '')

" scss linting
if filereadable("config/scss-lint.yml")
  let g:syntastic_scss_scss_lint_args = '--config config/scss_lint.yml'
  let g:syntastic_scss_scss_lint_exec = 'bundle exec scss-lint'
endif
if filereadable("Gemfile") && g:shopify_assets_location !~ "Could not find gem 'shopify_assets'"
  let g:syntastic_scss_scss_lint_args = '--config ' . g:shopify_assets_location . "/config/scss-lint.yml"
  let g:syntastic_scss_scss_lint_exec = substitute(system('bundle show scss_lint'), '\n\+$', '', '') . '/bin/scss-lint'
endif

" coffee linting
if filereadable("config/coffeelint.json")
  let g:syntastic_coffee_coffeelint_args = '-f config/coffeelint.json'
endif
if filereadable("Gemfile") && g:shopify_assets_location !~ "Could not find gem 'shopify_assets'"
  let g:syntastic_coffee_coffeelint_args = '-f ' . g:shopify_assets_location . "/config/coffeelint.json"
endif

let g:syntastic_quiet_messages = {
  \ "regex":   '\museless use of a variable in void context' }

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

let g:splice_initial_mode = "grid"
let g:splice_initial_layout_grid = 1

" vitality.vim
let g:vitality_fix_cursor = 1
let g:vitality_fix_focus = 1
let g:vitality_always_assume_iterm = 1

au InsertLeave * redraw!

nmap <leader>r :redraw!<cr>

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

" Numbers.vim
nnoremap <F3> :NumbersToggle<CR>

" Gitgutter
let g:gitgutter_on_bufenter = 0

colorscheme hypertint

hi NonText ctermfg=red guifg=#CA0908 gui=bold
hi SpecialKey ctermfg=red guifg=#CA0908 gui=bold

let autoreadargs={'autoread':1}
au BufRead,BufNewFile * :silent! execute WatchForChanges("*", autoreadargs)

let g:jsx_ext_required = 0

" vim-marked
nnoremap <localleader>m :MarkedOpen!<cr>

" dispatch
nnoremap <localleader>t :Dispatch<cr>
