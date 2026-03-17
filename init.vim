call plug#begin()
" File Navigation
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'coreyja/fzf.devicon.vim'

" UI Enhancements
Plug 'sainnhe/edge'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/everforest'
Plug 'sainnhe/gruvbox-material'
Plug 'onsails/lspkind.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'akinsho/bufferline.nvim'

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
Plug 'tpope/vim-fugitive'

" Syntax Highlighting & Code Navigation
Plug 'RRethy/vim-illuminate'
Plug 'luochen1990/rainbow'

" Comments
Plug 'preservim/nerdcommenter'
call plug#end()

" Editor settings (Vimscript — keymaps, options)
source ~/.config/nvim/editor.vim

" Plugins settings (Vimscript — non-lua plugins)
source ~/.config/nvim/plugins.vim

" Lua plugins (nvim-tree, lualine, onedark, bufferline, auto-save)
" Lua plugins (nvim-tree, lualine, onedark, bufferline, auto-save)
lua pcall(require, 'plugins.nvim-tree')
lua pcall(require, 'plugins.lualine')
lua pcall(require, 'plugins.onedark')
lua pcall(require, 'plugins.autosave')
lua pcall(require, 'plugins.bufferline')
