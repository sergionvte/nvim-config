" Vim-hexokinase
let g:Hexokinase_highlighters = [ 'virtual' ]

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
\ 'coc-java'
\ ]

" Signify
let g:signify_skip_filetype = { 'NvimTree': 1 }
highlight SignColumn        guibg=NONE
highlight SignifySignAdd    guifg=#00ff00 guibg=NONE
highlight SignifySignChange guifg=#ffff00 guibg=NONE
highlight SignifySignDelete guifg=#ff0000 guibg=NONE

" Rainbow
let g:rainbow_active=1

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
