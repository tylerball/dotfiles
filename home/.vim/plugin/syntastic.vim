" Syntastic
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'passive_filetypes': ['htmldjango', 'markdown', 'html'] }

let g:syntastic_python_checker_args='--ignore=E501'
let g:syntastic_javascript_checkers =['eslint', 'jshint']
let g:syntastic_scss_checkers = ['scss_lint']

let g:shopify_assets_location = substitute(system("bundle show shopify_assets"), '\n\+$', '', '')

" scss linting
if filereadable("config/scss-lint.yml")
  let g:syntastic_scss_scss_lint_args = '--config config/scss_lint.yml'
  let g:syntastic_scss_scss_lint_exec = 'bundle exec scss-lint'
endif
if filereadable("Gemfile") && g:shopify_assets_location !~ "Could not find gem 'shopify_assets'"
  let g:syntastic_scss_scss_lint_args = '--config ' . g:shopify_assets_location . "/config/scss-lint.yml"
  let g:syntastic_scss_scss_lint_exec = substitute(system('bundle show scss_lint'), '\n\+$', '', '') . '/bin/scss-lint'
endif

" coffee linting
if filereadable("config/coffeelint.json")
  let g:syntastic_coffee_coffeelint_args = '-f config/coffeelint.json'
endif
if filereadable("Gemfile") && g:shopify_assets_location !~ "Could not find gem 'shopify_assets'"
  let g:syntastic_coffee_coffeelint_args = '-f ' . g:shopify_assets_location . "/config/coffeelint.json"
endif

let g:syntastic_quiet_messages = {
  \ "regex":   '\museless use of a variable in void context' }
