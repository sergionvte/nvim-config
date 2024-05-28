-- init.lua Inicializar Packer
require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- File Navigation
    use 'preservim/nerdtree'
    use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
    use 'junegunn/fzf.vim'

    -- UI Enhancements
    use 'sainnhe/edge'
    use 'sainnhe/sonokai'
    use 'sainnhe/everforest'
    use 'sainnhe/gruvbox-material'
    use 'onsails/lspkind.nvim'
    use 'ryanoasis/vim-devicons'
    use 'itchyny/lightline.vim'

    -- Editing Enhancements
    use 'ervandew/supertab'
    use 'mhinz/vim-signify'
    use 'Yggdroot/indentLine'
    use 'mattn/emmet-vim'
    use 'andymass/vim-matchup'
    use 'jiangmiao/auto-pairs'
    use 'alvan/vim-closetag'
    use 'tpope/vim-surround'
    use 'AndrewRadev/tagalong.vim'
    use 'Pocco81/auto-save.nvim'
    use 'VonHeikemen/lsp-zero.nvim' branch = 'v3.x'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'L3MON4D3/LuaSnip'

    -- Syntax Highlighting & Code Navigation
    use 'RRethy/vim-illuminate'
    use 'luochen1990/rainbow'

    -- Comments
    use 'preservim/nerdcommenter'
end)

-- Cargar configuraciones del editor
require('settings')

-- Cargar mapeos de teclado
require('mappings')

-- Cargar tema
local current_theme = 'sonokai'
require('themes.' .. current_theme)
