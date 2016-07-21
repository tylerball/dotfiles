" Syntastic
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'passive_filetypes': ['htmldjango', 'markdown', 'html'] }

let g:shopify_assets_location = substitute(system("bundle show shopify_assets"), '\n\+$', '', '')
