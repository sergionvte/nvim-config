" Configuración de los plugins en VimScript (los declarados en spec.lua sin
" `config` en Lua). Los mapeos/globals que un plugin LEE AL CARGAR (no
" cuando vos los usás) no pueden vivir acá si ese plugin es lazy=false y
" carga antes que este archivo — ver la nota grande en init.lua sobre
" g:VM_maps / g:NERDCreateDefaultMappings para el porqué.

" Vim-hexokinase: resalta colores (#fff, rgb(...), etc.) directo en el texto.
let g:Hexokinase_highlighters = [ 'virtual' ]

" Vim-surround: en modo visual, escribir " o ' sobre la selección la envuelve
" directamente entre esas comillas (sin necesidad de pasar por S" / S').
xmap " S"
xmap ' S'

" Lo mismo con paréntesis, llaves y corchetes. El caracter de apertura agrega
" un espacio interno ( selección ), el de cierre lo deja pegado (selección) —
" es el mismo comportamiento que ya tenía vim-surround vía S( / S).
xmap ( S(
xmap ) S)
xmap { S{
xmap } S}
xmap [ S[
xmap ] S]

" Closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx'

" Conquer of Completion (coc)
nnoremap <leader>p :CocCommand prettier.forceFormatDocument<CR>
let g:coc_global_extensions = [
\ 'coc-tsserver',
\ 'coc-css',
\ 'coc-html',
\ 'coc-pyright',
\ 'coc-htmldjango',
\ 'coc-json',
\ 'coc-prettier',
\ 'coc-clangd',
\ 'coc-eslint',
\ 'coc-tailwindcss',
\ 'coc-snippets',
\ 'coc-emmet',
\ 'coc-svg',
\ 'coc-java',
\ 'coc-go',
\ 'coc-kotlin'
\ ]

" Sign column transparent (gitsigns' own highlights are set in
" lua/plugins/gitsigns.lua)
highlight SignColumn guibg=NONE

" Fzf
" nnoremap <C-m> :Buffer<CR>
nnoremap <CR> :silent! Buffers<CR>
nnoremap <C-j> :silent! Ag<CR>
nnoremap <C-k> :silent! Files<CR>
inoremap <A-delete> <NOP>

" NERD Commenter (g:NERDCreateDefaultMappings se define en init.lua, antes de
" que cargue el plugin — ver el comentario ahí para el motivo)
" Ctrl+C para toggle comment en normal y visual
nmap <C-c> <Plug>NERDCommenterToggle
vmap <C-c> <Plug>NERDCommenterTogglegv
