-- lazy.nvim plugin spec — 1:1 port of the old vim-plug list.
-- Every plugin keeps `lazy = false` so loading behaves exactly like before
-- (everything loaded eagerly at startup, same relative order as vim-plug).
return {
  -- File Navigation
  { 'nvim-tree/nvim-tree.lua', lazy = false },
  { 'nvim-tree/nvim-web-devicons', lazy = false },
  -- `./install --bin` is a shell script (no Windows equivalent here) and is
  -- redundant anyway if fzf is already installed system-wide (brew/scoop/apt).
  { 'junegunn/fzf', lazy = false, build = vim.fn.has('win32') == 0 and './install --bin' or nil },
  { 'junegunn/fzf.vim', lazy = false },
  { 'coreyja/fzf.devicon.vim', lazy = false },

  -- UI Enhancements
  { 'sainnhe/edge', lazy = false },
  { 'sainnhe/sonokai', lazy = false },
  { 'sainnhe/everforest', lazy = false },
  { 'sainnhe/gruvbox-material', lazy = false },
  { 'navarasu/onedark.nvim', lazy = false },
  { 'nvim-lualine/lualine.nvim', lazy = false },
  -- `make hexokinase` needs `make` + a Go toolchain; on Windows install a
  -- prebuilt binary per the plugin's README instead (see :h hexokinase-installation).
  { 'rrethy/vim-hexokinase', lazy = false, build = vim.fn.has('win32') == 0 and 'make hexokinase' or nil },
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
  { 'HiPhish/rainbow-delimiters.nvim', lazy = false },
  { 'nvim-treesitter/nvim-treesitter', lazy = false, branch = 'main', build = ':TSUpdate' },
  { 'styled-components/vim-styled-components', lazy = false, branch = 'main' },
  { 'honza/vim-snippets', lazy = false },
  { 'folke/flash.nvim', lazy = false },

  -- Comments
  { 'preservim/nerdcommenter', lazy = false },

  -- Code screenshots (polacode-style)
  { 'mistricky/codesnap.nvim', tag = 'v2.0.5', lazy = false },
}
