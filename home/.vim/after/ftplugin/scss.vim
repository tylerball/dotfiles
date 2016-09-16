if filereadable("config/scss-lint.yml")
  let g:neomake_scss_scsslint_args = '--config config/scss_lint.yml'
  let g:neomake_scss_scsslint_exec = 'bundle exec scss-lint'
endif
if filereadable("Gemfile") && g:shopify_assets_location !~ "Could not find gem 'shopify_assets'"
  let g:neomake_scss_scsslint_args = '--config ' . g:shopify_assets_location . "/config/scss-lint.yml"
endif

let g:NERDCustomDelimiters = {
    \ 'scss': { 'left': '// ' },
\ }
