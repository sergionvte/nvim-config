" NerdTree
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
autocmd VimEnter * if !argc() | execute 'NERDTree' | wincmd p | q | endif " Abre NERDTree al iniciar nvim
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
