" airline
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : '',
    \ 'i'  : '',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'VL',
    \ '' : 'VB',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }
let g:airline_section_y = ''
let g:airline#themes#tyler#palette = {}
let s:N1 = ['#282828', '#dc9656', 18, 9]
let s:N2 = ['#f8f8f8', '#383838', 7, 2]
let s:N3 = ['#b8b8b8', '#282828', 4, 1]
let g:airline#themes#tyler#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#tyler#palette.normal_modified = {
\ 'airline_c': ['#181818', '#ba8baf', 0, 5, ''],
\ }
let s:WI = ['#181818', '#ab4642', 0, 9]
let g:airline#themes#tyler#palette.normal.airline_warning = [
\ s:WI[0], s:WI[1], s:WI[2], s:WI[3]
\ ]

let s:I1 = ['#181818', '#86c1b9', 0, 6]
let s:I2 = ['#d8d8d8', '#005fff', 7, 27]
let g:airline#themes#tyler#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:N3)
let g:airline#themes#tyler#palette.insert_modified = {
\ 'airline_c': ['#ffffff', '#5f005f', 255, 53, ''],
\ }
let g:airline#themes#tyler#palette.insert_paste = {
\ 'airline_a': [ s:I1[0], '#d78700', s:I1[2], 172, ''] ,
\ }
let g:airline#themes#tyler#palette.replace = copy(g:airline#themes#tyler#palette.insert)
let g:airline#themes#tyler#palette.replace.airline_a = [s:I2[0], '#af0000', s:I2[2], 124, '']
let g:airline#themes#tyler#palette.replace_modified = g:airline#themes#tyler#palette.insert_modified
let s:V1 = ['#181818', '#ffaf00', 0, 214]
let s:V2 = ['#181818', '#ff5f00', 0, 202]
let s:V3 = ['#ffffff', '#5f0000', 15, 52]
let g:airline#themes#tyler#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#tyler#palette.visual_modified = {
\ 'airline_c': ['#ffffff', '#5f005f', 255, 53, ''],
\ }
let s:IA1 = ['#4e4e4e', '#1c1c1c', 239, 234, '']
let s:IA2 = ['#4e4e4e', '#262626', 239, 235, '']
let s:IA3 = ['#4e4e4e', '#303030', 239, 236, '']
let g:airline#themes#tyler#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
let g:airline#themes#tyler#palette.inactive_modified = {
\ 'airline_c': ['#ba8baf', '', 5, '', ''] ,
\ }
let g:airline#themes#tyler#palette.accents = {
\ 'red': ['#dc9656', '', 9, '']
\ }

let g:airline_theme='tyler'
