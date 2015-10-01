" Vim plugin settings

"Ack
"nnoremap <leader>a :Ack!<space>

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
  let g:unite_source_rec_async_command = 
        \['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '-i --vimgrep --hidden'
  let g:unite_source_grep_recursive_opt = ''
end
nnoremap <C-p> :Unite -buffer-name=search file_rec/async buffer -resume -start-insert<CR><Esc>GC
nnoremap <C-b> :Unite -buffer-name=buffers buffer -start-insert<CR><Esc>GC
nnoremap <leader>a :Unite -buffer-name=grep -no-quit grep:.<CR>
nnoremap <C-c> :Unite -buffer-name=yank -default-action=insert history/yank<CR>
nnoremap <C-f> :Unite -buffer-name=search -start-insert line<CR>
nnoremap <leader>ur :UniteResume search<CR>
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

" Syntastic
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'passive_filetypes': ['htmldjango', 'markdown', 'html'] }

let g:syntastic_python_checker_args='--ignore=E501'
let g:syntastic_javascript_checkers =['eslint', 'jshint']
let g:syntastic_scss_checkers = ['scss_lint']
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
