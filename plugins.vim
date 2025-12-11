" NerdTree
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
"autocmd VimEnter * if !argc() | execute 'NERDTree' | wincmd p | q | endif " Abre NERDTree al iniciar nvim
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>

" Vim-hexokinase
let g:Hexokinase_highlighters = [ 'virtual' ]

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

" Rainbow
let g:rainbow_active=1

" Auto-save
let g:auto_save_silent = 1
autocmd VimEnter * ASToggle

" Fzf
nnoremap <C-m> :Buffer<CR>
nnoremap <C-h> :Ag<CR>
nnoremap <C-l> :Files<CR>

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

" Vim-buffet (barra de buffers)
let g:buffet_always_show_tabline = 1
let g:buffet_powerline_separators = 1
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"
let g:buffet_show_index = 1
let g:buffet_max_plug = 10
let g:buffet_use_devicons = 1
let g:buffet_separator = ""

" Mapeos para navegar entre buffers
nnoremap <silent><Tab> :bn<CR>
nnoremap <silent><S-Tab> :bp<CR>
nnoremap <silent><leader>x :bd<CR>
nnoremap <silent><leader>1 <Plug>BuffetSwitch(1)
nnoremap <silent><leader>2 <Plug>BuffetSwitch(2)
nnoremap <silent><leader>3 <Plug>BuffetSwitch(3)
nnoremap <silent><leader>4 <Plug>BuffetSwitch(4)
nnoremap <silent><leader>5 <Plug>BuffetSwitch(5)
