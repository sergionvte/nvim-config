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
autocmd BufWritePre * :%s/\s\+$//e

" Mappings
noremap <space> :
nnoremap w e
nnoremap e w
nmap <silent>// :nohlsearch<CR>
nmap ñ $
nmap ' $
nmap Ñ 0
nmap J G
nmap K gg
nmap ,, ciw
nmap .. diw
nmap -- cs
vnoremap w e
vnoremap e w
vmap ñ $
vmap ' $
vmap Ñ 0
vmap J G
vmap K gg
