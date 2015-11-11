au BufNewFile,BufRead *.watchr set filetype=ruby

setl expandtab ts=2 shiftwidth=2 softtabstop=2
setl expandtab ts=2 shiftwidth=2 softtabstop=2

au FileType ruby let b:dispatch = 'bundle exec ruby -Itest %'
