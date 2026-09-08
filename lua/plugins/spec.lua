-- lazy.nvim plugin spec — 1:1 port of the old vim-plug list.
-- Every plugin keeps `lazy = false` so loading behaves exactly like before
-- (everything loaded eagerly at startup, same relative order as vim-plug).
return {
  -- File Navigation
  { 'nvim-tree/nvim-tree.lua', lazy = false },
  { 'nvim-tree/nvim-web-devicons', lazy = false },
  { 'junegunn/fzf', lazy = false, build = './install --bin' },
  { 'junegunn/fzf.vim', lazy = false },
  { 'coreyja/fzf.devicon.vim', lazy = false },

  -- UI Enhancements
  { 'sainnhe/edge', lazy = false },
  { 'sainnhe/sonokai', lazy = false },
  { 'sainnhe/everforest', lazy = false },
  { 'sainnhe/gruvbox-material', lazy = false },
  { 'navarasu/onedark.nvim', lazy = false },
  { 'nvim-lualine/lualine.nvim', lazy = false },
  { 'rrethy/vim-hexokinase', lazy = false, build = 'make hexokinase' },
  { 'akinsho/bufferline.nvim', lazy = false },

  -- Editing Enhancements
  { 'mhinz/vim-signify', lazy = false },
  { 'lukas-reineke/indent-blankline.nvim', lazy = false },
  { 'andymass/vim-matchup', lazy = false },
  { 'jiangmiao/auto-pairs', lazy = false },
  { 'alvan/vim-closetag', lazy = false },
  { 'tpope/vim-surround', lazy = false },
  { 'AndrewRadev/tagalong.vim', lazy = false },
  { 'Pocco81/auto-save.nvim', lazy = false },
  { 'neoclide/coc.nvim', lazy = false, branch = 'master', build = 'yarn install --frozen-lockfile' },
  { 'tpope/vim-fugitive', lazy = false },
  { 'mg979/vim-visual-multi', lazy = false, branch = 'master' },

  -- Syntax Highlighting & Code Navigation
  { 'RRethy/vim-illuminate', lazy = false },
  { 'luochen1990/rainbow', lazy = false },
  { 'nvim-treesitter/nvim-treesitter', lazy = false, branch = 'main', build = ':TSUpdate' },
  { 'styled-components/vim-styled-components', lazy = false, branch = 'main' },
  { 'honza/vim-snippets', lazy = false },
  { 'folke/flash.nvim', lazy = false },

  -- Comments
  { 'preservim/nerdcommenter', lazy = false },
}
