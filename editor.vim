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
set expandtab
set mouse=a
set ts=2
set shiftwidth=2
set noshowmode
set clipboard=unnamedplus
set number relativenumber
set ignorecase smartcase
set hidden
set cursorline
set updatetime=300

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
nmap ,, ciw
nmap .. #
nmap -- cs
vnoremap w e
vnoremap e w
vmap ñ $
vmap ' $
vmap J G
vmap K gg
inoremap <silent><expr> <cr> "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <tab> pumvisible() ? coc#select_confirm() : "\<C-g>u\<tab>"

