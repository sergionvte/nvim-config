" Vim-hexokinase
let g:Hexokinase_highlighters = [ 'virtual' ]

" Indent Line
let g:indentLine_bufTypeExclude = ['nofile']
let g:indentLine_fileTypeExclude = ['NvimTree']

" Conquer of Completion (coc)
nnoremap <leader>p :CocCommand prettier.forceFormatDocument<CR>
let g:coc_global_extensions = [
\ 'coc-tslint-plugin',
\ 'coc-tsserver',
\ 'coc-css',
\ 'coc-html',
\ 'coc-pyright',
\ 'coc-htmldjango',
\ 'coc-json',
\ 'coc-prettier',
\ 'coc-clangd'
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
nnoremap <CR> :Buffers<CR>
nnoremap <C-j> :Ag<CR>
nnoremap <C-k> :Files<CR>
inoremap <A-delete> <NOP>

" Emmet
let g:user_emmet_leader_key=','
let g:user_emmet_settings = {
\  'variables': {'lang': 'en'},
\  'html': {
\    'default_attributes': {
\      'option': {'value': v:null},
\      'textarea': {'id': v:null, 'name': v:null, 'cols': 10, 'rows': 10},
\    },
\    'snippets': {
\      'html:5': "<!DOCTYPE html>\n"
\              ."<html lang=\"${lang}\">\n"
\              ."<head>\n"
\              ."\t<meta charset=\"${charset}\">\n"
\              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
\              ."\t<title></title>\n"
\              ."</head>\n"
\              ."<body>\n\t${child}|\n</body>\n"
\              ."</html>",
\    },
\  },
\}

" NERD Commenter
" Deshabilitar mappings por defecto para evitar conflictos
let g:NERDCreateDefaultMappings = 0

" Ctrl+C para toggle comment en normal y visual
nmap <C-c> <Plug>NERDCommenterToggle
vmap <C-c> <Plug>NERDCommenterTogglegv
