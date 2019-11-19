function! s:setup_obsession()
  if '.git/' =~ join(argv()) " don't start/source sessions for git stuff
    if filereadable("Session.vim")
      source Session.vim
    else
      Obsession .
    endif
  end
endfunction
autocmd VimEnter * nested call s:setup_obsession()
