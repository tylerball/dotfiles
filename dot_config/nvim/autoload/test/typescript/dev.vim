function! test#typescript#dev#test_file(file) abort
 return a:file =~# '\v\.test\.(ts|tsx)$'
endfunction

function! test#typescript#dev#build_position(type, position) abort
  if a:type ==# 'nearest'
    let name = s:nearest_test(a:position)
    if !empty(name)
      let name = '--no-coverage -t '.shellescape(name, 1)
    endif
    return [name, '--', a:position['file']]
  elseif a:type ==# 'file'
    return ['--', a:position['file']]
  else
    return []
  endif
endfunction

function! test#typescript#dev#build_args(args) abort
  return a:args
endfunction

function! test#typescript#dev#executable() abort
  if filereadable('node_modules/.bin/sewing-kit')
    return 'node_modules/.bin/sewing-kit test --watch=false'
  else
    return 'sewing-kit test --watch=false'
  endif
endfunction

function! s:nearest_test(position) abort
  let name = test#base#nearest_test(a:position, g:test#javascript#patterns)
  return (len(name['namespace']) ? '^' : '') .
       \ test#base#escape_regex(join(name['namespace'] + name['test'])) .
       \ (len(name['test']) ? '$' : '')
endfunction
