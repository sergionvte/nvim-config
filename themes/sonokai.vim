" Theme
let g:sonokai_style='default'
let g:sonokai_enable_italic=1
let g:sonokai_enable_bold=1
let g:sonokai_transparent_background=2
let g:sonokai_current_word='underline'
let g:lightline={'colorscheme': 'sonokai'}
let g:cursor='yellow'
if has('termguicolors')
  set termguicolors
endif
set background=dark
colorscheme sonokai
highlight! link BuffetCurrentBuffer TabLineSel
highlight! link BuffetActiveBuffer TabLineSel
highlight! link BuffetBuffer TabLine
highlight! link BuffetTab TabLineFill
highlight! link BuffetTrunc TabLineFill
