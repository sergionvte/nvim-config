" Configuración "core" del editor: opciones generales, atajos de movimiento
" y edición que no son específicos de ningún plugin. La config de cada
" plugin vive en su propio archivo:
"   - plugins.vim         -> plugins en VimScript
"   - lua/plugins/*.lua    -> plugins en Lua
"   - lua/config/*.lua     -> utilidades propias (sin plugin externo)
" Todo se carga desde init.lua. Ver el README.md en la raíz del repo para
" una explicación completa de la config y sus atajos.

" Define leader key
let mapleader = "\\"

" Buscar la palabra sobre la que esta el cursor
nnoremap /. :let @/=expand('<cword>')<CR>n

" Function to reload configuration
if !exists('*ReloadConfig')
  function! ReloadConfig()
    let l:config_dir = stdpath('config')
    execute 'source ' . l:config_dir . '/init.lua'
    execute 'source ' . l:config_dir . '/editor.vim'
    execute 'source ' . l:config_dir . '/plugins.vim'
  endfunction
endif

" Asignar <leader><leader> para recargar la configuración
nnoremap <leader><leader> :call ReloadConfig()<CR>

" Format on save toggle
let g:format_on_save = 1
command! ToggleFormat let g:format_on_save = !g:format_on_save | echo "Format on save: " . (g:format_on_save ? "Enabled" : "Disabled")
nnoremap <leader>f :ToggleFormat<CR>

" Editor settings
lua vim.opt.fillchars:append({ eob = " " })
set termguicolors
set numberwidth=1
set expandtab
set mouse=a
set ts=4
set shiftwidth=4
set softtabstop=4
set noshowmode
set clipboard=unnamedplus
set number relativenumber
set ignorecase smartcase
set hidden
set cursorline
set timeoutlen=300
set ttimeoutlen=10
set updatetime=100
set undofile

autocmd FileType python setlocal tabstop=4 shiftwidth=4
autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
function! s:StripTrailingWhitespace()
  let l:view = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:view)
endfunction
autocmd BufWritePre * call s:StripTrailingWhitespace()

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

" Snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)


" Ejecutar el archivo actual con Ctrl+Enter / Ctrl+Alt+Enter: ver
" lua/config/run_file.lua (portable entre Python3/Python y sin rutas /tmp
" fijas, para que funcione igual en Windows/Linux/macOS).

" Mover línea (normal) o bloque seleccionado (visual) hacia arriba/abajo con
" alt+shift+j/k. == / gv=gv reindenta después de mover.
nnoremap <silent> <M-J> :m .+1<CR>==
nnoremap <silent> <M-K> :m .-2<CR>==
xnoremap <silent> <M-J> :m '>+1<CR>gv=gv
xnoremap <silent> <M-K> :m '<-2<CR>gv=gv

" Borrar palabra hacia atras
imap <A-BS> <C-w>
imap <Esc><BS> <C-w>

" CoC
nmap <leader>h :CocCommand document.toggleInlayHint<CR>

" Multicursor (vim-visual-multi): la configuración de sus teclas vive en
" init.lua, ANTES de que lazy.nvim cargue los plugins — VM lee g:VM_maps una
" sola vez al arrancar, así que definirla aquí (que se sourcea después) nunca
" surtía efecto.
