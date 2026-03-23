" Define leader key
let mapleader = "\\"

" Buscar la palabra sobre la que esta el cursor
nnoremap /. :let @/=expand('<cword>')<CR>n

" Function to reload configuration
if !exists('*ReloadConfig')
  function! ReloadConfig()
    source ~/.config/nvim/init.vim
    source ~/.config/nvim/editor.vim
    source ~/.config/nvim/plugins.vim
  endfunction
endif

" Asignar <leader><leader> para recargar la configuración
nnoremap <leader><leader> :call ReloadConfig()<CR>

" Editor settings
lua vim.opt.fillchars:append({ eob = " " })
set numberwidth=1
set expandtab
set mouse=a
set ts=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshowmode
set clipboard=unnamedplus
set number relativenumber
set ignorecase smartcase
set hidden
set cursorline

autocmd FileType python setlocal tabstop=4 shiftwidth=4
autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
autocmd BufWritePre * :%s/\s\+$//e

" Mappings
noremap <space> :
nnoremap w e
nnoremap e w
nmap <silent>// :nohlsearch<CR>
nmap ñ $
nmap Ñ 0
nmap J G
nmap K gg
nmap L $
nmap H 0
nmap ,, ciw
nmap .. #
nmap -- cs
nnoremap U <C-r>
vnoremap w e
vnoremap e w
vmap ñ $
vmap ' $
vmap L $
vmap H 0
vmap J G
vmap K gg

" Usar Tab para aceptar sugerencia, Shift+Tab para navegar hacia atrás
inoremap <silent><expr> <TAB> pumvisible() ? coc#_select_confirm() : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Shift+Enter también acepta la sugerencia
inoremap <silent><expr> <S-CR> pumvisible() ? coc#_select_confirm() : "\<CR>"

" Enter normal sin confirmar sugerencia
inoremap <silent><expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Navegación entre buffers
nnoremap <silent><Tab> :BufferLineCycleNext<CR>
nnoremap <silent><S-Tab> :BufferLineCyclePrev<CR>
nnoremap <silent><leader>x :bdelete<CR>
nnoremap <silent><C-x> :bdelete<CR>


" Ejecutar Python con Ctrl + Enter
autocmd FileType python nnoremap <buffer> <C-CR> :w<CR>:split \| terminal python3 %<CR>i

" Borrar palabra hacia atras
imap <A-BS> <C-w>
imap <Esc><BS> <C-w>

" CoC
nmap <leader>h :CocCommand document.toggleInlayHint<CR>
nmap <C-A-Down> <Plug>(coc-cursors-position)j
nmap <C-A-Up> <Plug>(coc-cursors-position)k
xmap <C-A-Down> <Plug>(coc-cursors-range)j
xmap <C-A-Up> <Plug>(coc-cursors-range)k

" Multicursor - seleccionar siguiente ocurrencia (cmd+d)
nmap <C-S-D> <Plug>(coc-cursors-word)
xmap <C-S-D> <Plug>(coc-cursors-range)

" Multicursor - agregar cursor arriba/abajo
nmap <C-A-Down> <Plug>(coc-cursors-position)j
nmap <C-A-Up> <Plug>(coc-cursors-position)k
xmap <C-A-Down> <Plug>(coc-cursors-range)j
xmap <C-A-Up> <Plug>(coc-cursors-range)k

" Deshabilitar todos los keymaps por defecto
let g:VM_default_mappings = 0

" Multicursor - seleccionar siguiente ocurrencia (cmd+d)
let g:VM_maps = {}
let g:VM_maps['Find Under'] = '<C-A-d>'
let g:VM_maps['Find Subword Under'] = '<C-A-d>'

" Multicursor - agregar cursor arriba/abajo
let g:VM_maps['Add Cursor Down'] = '<C-A-Down>'
let g:VM_maps['Add Cursor Up'] = '<C-A-Up>'
let g:VM_maps['Skip Region'] = '<C-x>'
