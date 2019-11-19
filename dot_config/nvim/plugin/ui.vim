set shortmess=WatAITo " Stifle interruptive prompts http://items.sjbach.com/319/configuring-vim-right
set number
set visualbell
set cursorline
set listchars=tab:>·,trail:·,extends:»,precedes:«
set list
set scrolloff=5 " adds 5 lines of space to the top and bottom relative to the cursor
set colorcolumn=+1
set clipboard=unnamed
set laststatus=2
set equalalways
set splitbelow
set splitright
set diffopt=filler,vertical
set foldlevelstart=999
set noswapfile
set mouse=a

au WinEnter * setlocal cursorline
au WinLeave * setlocal nocursorline

" resize splits when window is resized
au VimResized * exe "normal! \<c-w>="

" auto resize quickfix windows
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" Colors
set termguicolors
let g:lightline = {
\   'colorscheme': 'base16'
\ }
au BufNew * call matchadd('Todo', 'TODOF')
au BufNew * call matchadd('Todo', 'TODOB')
au BufNew * call matchadd('Todo', 'TODO')
hi Todo guifg=#AC000B ctermfg=124

let g:lightline.component_function = {
\ 'filename': 'LightlineFilename',
\ 'gitbranch': 'fugitive#head'
\ }

let g:lightline.active = {}
let g:lightline.active.right = [
\ [ 'lineinfo' ],
\ [ 'filetype' ],
\ [ 'gitbranch' ]
\ ]

function! LightlineFilename()
  if expand('%:t') == ''
    return '[No Name]'
  else
    return winwidth(0) > 80 ? expand('%') : expand('%:t')
  endif
endfunction

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

nnoremap <F8> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

let g:goyo_width = '85'
