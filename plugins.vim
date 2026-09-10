" Vim-hexokinase
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
\ 'coc-go'
\ ]

" Signify
let g:signify_skip_filetype = { 'NvimTree': 1 }
highlight SignColumn        guibg=NONE
highlight SignifySignAdd    guifg=#00ff00 guibg=NONE
highlight SignifySignChange guifg=#ffff00 guibg=NONE
highlight SignifySignDelete guifg=#ff0000 guibg=NONE

" Fzf
" nnoremap <C-m> :Buffer<CR>
nnoremap <CR> :silent! Buffers<CR>
nnoremap <C-j> :silent! Ag<CR>
nnoremap <C-k> :silent! Files<CR>
inoremap <A-delete> <NOP>

" NERD Commenter
" Deshabilitar mappings por defecto para evitar conflictos
let g:NERDCreateDefaultMappings = 0

" Ctrl+C para toggle comment en normal y visual
nmap <C-c> <Plug>NERDCommenterToggle
vmap <C-c> <Plug>NERDCommenterTogglegv
