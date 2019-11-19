au BufNewFile,BufRead *.watchr set filetype=ruby

setl expandtab ts=2 shiftwidth=2 softtabstop=2
setl expandtab ts=2 shiftwidth=2 softtabstop=2

let g:test#ruby#minitest#executable = 'bundle exec ruby -Itest'
let g:test#ruby#rails#file_pattern = ''

let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_block_style = 'do'
