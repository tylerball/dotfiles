setl expandtab ts=4 shiftwidth=4 softtabstop=4
setl expandtab ts=4 shiftwidth=4 softtabstop=4

" Indenting
let g:pyindent_open_paren = '&sw'
let g:pyindent_nested_paren = '&sw'
let g:pyindent_continue = '&sw'

let python_highlight_all = 1

setlocal textwidth=79
setlocal shiftwidth=4

setlocal omnifunc=pythoncomplete#Complete

" go to a file in a python import
python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

let g:syntastic_python_checker_args='--ignore=E501'
