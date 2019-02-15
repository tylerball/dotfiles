let g:LanguageClient_serverCommands = {
  \ 'ruby': ['tcp://localhost:7658'],
  \ 'javascript': ['javascript-typescript-stdio'],
  \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <localleader>f :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> <localleader>r :call LanguageClient_textDocument_rename()<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set completeopt=noinsert,menuone,noselect
set shortmess+=c

imap <C-Space> <Plug>snipMateTrigger

let g:ale_ruby_solargraph_executable = 'solargraph'
