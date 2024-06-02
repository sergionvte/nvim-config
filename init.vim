call plug#begin()
" File Navigation
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'coreyja/fzf.devicon.vim'

" UI Enhancements
Plug 'sainnhe/edge'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/everforest'
Plug 'sainnhe/gruvbox-material'
Plug 'onsails/lspkind.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Editing Enhancements
Plug 'mhinz/vim-signify'
Plug 'Yggdroot/indentLine'
Plug 'mattn/emmet-vim'
Plug 'andymass/vim-matchup'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/tagalong.vim'
Plug 'Pocco81/auto-save.nvim'
Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
Plug 'ervandew/supertab'

" Syntax Highlighting & Code Navigation
Plug 'RRethy/vim-illuminate'
Plug 'luochen1990/rainbow'

" Comments
Plug 'preservim/nerdcommenter'
call plug#end()

" Neovim settings
source ~/.config/nvim/editor.vim

" Plugins settings
source ~/.config/nvim/plugins.vim

" Theme settings
source ~/.config/nvim/themes/sonokai.vim
