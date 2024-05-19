" Theme
let g:gruvbox_material_background='hard'
let g:gruvbox_material_foreground='material'
let g:gruvbox_material_enable_bold=1
let g:gruvbox_material_transparent_background=1
let g:gruvbox_material_ui_contrast='high'
let g:gruvbox_spell_foreground='colored'
let g:gruvbox_material_current_word='grey background'
let g:lightline={'colorscheme': 'gruvbox_material'}

"let g:everforest_background='hard'
"let g:everforest_enable_italic=1
"let g:everforest_enable_bold=1
"let g:everforest_transparent_background=2
"let g:everforest_current_word='grey background'
"let g:lightline={'colorscheme': 'everforest'}
if has('termguicolors')
  set termguicolors
endif
set background=dark
colorscheme gruvbox-material
"colorscheme everforest
