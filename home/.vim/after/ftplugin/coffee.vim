let b:dispatch = 'bundle exec teaspoon -f clean %'
au User Rails let b:dispatch = 'bundle exec teaspoon -f clean %'

hi link coffeeObjAssign Keyword

if filereadable("config/coffeelint.json")
  let g:syntastic_coffee_coffeelint_args = '-f config/coffeelint.json'
endif
if filereadable("Gemfile") && g:shopify_assets_location !~ "Could not find gem 'shopify_assets'"
  let g:syntastic_coffee_coffeelint_args = '-f ' . g:shopify_assets_location . "/config/coffeelint.json"
endif
