" Editor settings
set expandtab
set mouse=a
set ts=2
set shiftwidth=2
set noshowmode
set clipboard=unnamedplus
set number relativenumber
autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
nmap <silent>// :nohlsearch<CR>

" Mappings
nmap ñ $
nmap ' $
nmap Ñ 0
nmap J G
nmap K gg
nmap ,, ciw
nmap .. diw
nmap -- cs
vmap ñ $
vmap ' $
vmap Ñ 0
vmap J G
vmap K gg

" Theme
let g:gruvbox_material_background='hard'
let g:gruvbox_material_foreground='material'
let g:gruvbox_material_enable_bold=1
let g:gruvbox_material_transparent_background=1
let g:gruvbox_material_ui_contrast='high'
let g:gruvbox_spell_foreground='colored'
let g:lightline={'colorscheme': 'gruvbox_material'}
if has('termguicolors')
  set termguicolors
endif
set background=dark
colorscheme gruvbox-material
