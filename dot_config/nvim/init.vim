syntax on

let mapleader = ","
let maplocalleader = "\\"

let g:python3_host_prog = $HOME."/.config/nvim/virtualenv/bin/python3"

lua require('plugins')

lua require('gitsigns').setup()

lua require('lsp')

lua require('completion')

" vim-test
nmap <silent> <localleader>t :TestNearest<CR>
nmap <silent> <localleader>T :TestFile<CR>
nmap <silent> <localleader>l :TestLast<CR>
nmap <silent> <localleader>g :TestVisit<CR>

set exrc

autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path "%"
