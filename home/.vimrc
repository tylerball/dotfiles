" Setup
" -----
    set nocompatible

    if filereadable(expand("~/.vim/autoload/plug.vim"))
        let g:local = 1
    else
        let g:local = 0
    endif

    syntax on
    set encoding=utf-8        "" set as utf-8 encoding

    if !has('nvim')
      set shell=$SHELL
    end

" Interface
" ---------
    set shortmess=WatAIT        "" Stifle interruptive prompts http://items.sjbach.com/319/configuring-vim-right
    set title                   "" Set the window title
    set number                  "" Show line numbers
    set showmode                "" indicate mode
    set showcmd                 "" show current command
    set visualbell              "" visual instead of beep
    set cursorline              "" highlight the current line
    set listchars=tab:>·,trail:·,extends:»,precedes:«
    set list
    set scrolloff=5             "" adds 5 lines of space to the top and bottom relative to the cursor

    if g:local
        set ttyfast
    endif

    set mouse=a
    if has("mouse_sgr") && !has('nvim')
      set ttymouse=sgr
    endif
    set notimeout           "" don't timeout on command line
    set autowriteall           "" write the damn files!
    set autoread            "" read the damn files

    set background=dark

    set clipboard=unnamed

    au WinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline

    " Don't automatically insert comments after single line comments
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    setlocal comments-=://
    setlocal comments+=f://

    set laststatus=2                       "" always have a status bar

    set splitbelow                         "" split windows below current
    set splitright                         "" split windows to the right
    set fillchars=vert:\│                  "" fancy splits for diff windows
    set diffopt=filler,vertical

    " resize splits when window is resized
    au VimResized * exe "normal! \<c-w>="

    " auto resize quickfix windows
    au FileType qf call AdjustWindowHeight(3, 10)
    function! AdjustWindowHeight(minheight, maxheight)
        exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
    endfunction

" Files
" -----
    if has('undofile')
        set undofile                   ""  keep a record of all undos
    endif
    set nobackup                   ""  What year is it?
    set backupskip=/tmp/*,/private/tmp/* "" crontab
    set noswapfile                 ""  see above
    set dir=~/.vimswap//.          ""  just in case
    if has('undodir')
        set undodir=~~/.vimswap/undo// ""  store undo files here
    endif
    set history=1000               ""  number of lines of cmd-lines stored
    if has('undoreload')
        set undoreload=10000
    endif

    set wildmenu                                    "" tab completion of filenames
    set wildmode=list:longest
    set wildignore+=.git,.svn,*.jpg,*.gif,*.png,*.jpeg,*.DS_Store,*.pyc
    set hidden           "" don't close if theres hidden buffers

    set foldlevelstart=999

" Searching
" ---------
    " Normal regexes please
    nnoremap / /\v
    vnoremap / /\v

    set ignorecase
    set smartcase
    set gdefault
    set incsearch
    set showmatch
    set hlsearch

    " Ack for the last search
    nnoremap <silent> <localleader>? :execute "Ack! '" . substitute(substitute(substitute(@/, "\\\\<","\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>

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

    " Keep search matches in the middle of the window and pulse the line when moving
    " to them.
    nnoremap n nzzzv
    nnoremap N Nzzzv

" Highlighting
" ------------
    " Highlight VCS conflict markers
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

    nnoremap <F8> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" }}}
" Formatting
" ----------
    set expandtab        "" converts tab keypresses to spaces
    set tabstop=2        "" number of spaces that a <tab> count for
    set shiftwidth=2     "" sets number of spaces used for (auto)indent
    set sts=2            "" number of spaces deleted when you hit <bs>
    set wrap
    set textwidth=79     "" Be like other people
    set colorcolumn=+1   "" highlight column after textwidth
    set smarttab         "" Smarter tab levels

    set formatoptions=lt "" see http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table

    set autoindent       "" set autoindenting

    set backspace=indent,eol,start

" Bindings
" --------
    let mapleader = ","
    let maplocalleader = "\\"
    inoremap kj <ESC>
    inoremap kJ <ESC>
    inoremap KJ <ESC>

    " can't type
    :command W w
    :command Q q
    :command Wq wq
    :command WQ wq

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

    " split navigation
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    "tabs
    nnoremap <C-t> :tabnew<CR>

    " Sudo to write
    cmap w!! w !sudo tee % >/dev/null

    " Switch indentations
    nnoremap <leader>2 :setlocal sw=2<cr> :setlocal ts=2<cr>
    nnoremap <leader>4 :setlocal sw=4<cr> :setlocal ts=4<cr>

    " copy a file
    nnoremap <localleader>y :silent !cat "%" \| pbcopy<cr>:redraw!<cr>

    " fuck ex
    nmap Q <nop>

" Words
" -----
    set dictionary=/usr/share/dict/words

    au BufWinEnter * call matchadd('Todo', 'TODOF')
    au BufWinEnter * call matchadd('Todo', 'TODOB')
    au BufWinEnter * call matchadd('Todo', 'TODO')

" Plugins
" -------
    " only load plugins on a local system
    if g:local
        :so $HOME/.vim/settings/plugins.vim
    :endif

" override settings locally if necessary
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" override settings in a project
if filereadable(glob(".vimrc.local"))
    source .vimrc.local
endif
