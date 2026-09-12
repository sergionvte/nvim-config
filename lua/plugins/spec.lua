-- lazy.nvim plugin spec — originally a 1:1 port of the old vim-plug list
-- with everything `lazy = false` (eager, same order as vim-plug). Most
-- plugins are still eager for simplicity, but a couple of the heavier ones
-- (nvim-tree, codesnap.nvim) are now lazy-loaded on the keys/commands that
-- actually trigger them — see the comment on each for why. When a plugin's
-- own config lives in a separate lua/plugins/<name>.lua module, it's wired
-- up via that plugin's `config` function here (required only once lazy.nvim
-- actually loads the plugin) rather than in init.lua's eager pcall-require
-- list, which is reserved for plugins that stay `lazy = false`.
return {
  -- File Navigation
  -- Only opened via keys, never at startup, so load it on first press
  -- instead of on every single startup (saves ~30ms every time it's unused).
  {
    'nvim-tree/nvim-tree.lua',
    keys = {
      { '<C-n>', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle file tree' },
      { '<C-b>', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle file tree' },
      { '<leader>n', '<cmd>NvimTreeFocus<CR>', desc = 'Focus file tree' },
    },
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeOpen' },
    init = function()
      -- Must run before nvim-tree loads, so it can't live in the lazy-loaded config module.
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      require('plugins.nvim-tree')
    end,
  },
  { 'nvim-tree/nvim-web-devicons', lazy = false },
  -- `./install --bin` is a shell script (no Windows equivalent here) and is
  -- redundant anyway if fzf is already installed system-wide (brew/scoop/apt).
  { 'junegunn/fzf', lazy = false, build = vim.fn.has('win32') == 0 and './install --bin' or nil },
  { 'junegunn/fzf.vim', lazy = false },
  { 'coreyja/fzf.devicon.vim', lazy = false },

  -- UI Enhancements
  -- (sainnhe/edge, sonokai, everforest, gruvbox-material used to be here:
  -- colorscheme-only plugins with no plugin/ script cost nothing at startup
  -- either way since :colorscheme is what actually loads them, but none of
  -- them are in use — onedark is the only colorscheme ever set — so they
  -- were just dead weight in the plugin list/lockfile. Removed.)
  { 'navarasu/onedark.nvim', lazy = false },
  { 'nvim-lualine/lualine.nvim', lazy = false },
  -- `make hexokinase` needs `make` + a Go toolchain; on Windows install a
  -- prebuilt binary per the plugin's README instead (see :h hexokinase-installation).
  { 'rrethy/vim-hexokinase', lazy = false, build = vim.fn.has('win32') == 0 and 'make hexokinase' or nil },
  { 'akinsho/bufferline.nvim', lazy = false },

  -- Editing Enhancements
  -- These only matter once a real buffer is open (nothing to highlight/
  -- indent/match/gutter-mark before that), so `event` defers loading each
  -- one until BufReadPre/BufNewFile instead of every startup. Using the
  -- *Pre* event (not BufReadPost) matters: lazy.nvim loads the plugin and
  -- lets its own autocmds pick up from there normally, but only if the
  -- plugin hasn't already missed the event it cares about — vim-signify's
  -- own setup listens on the plain BufRead event, which fires *before*
  -- BufReadPost, so triggering on BufReadPost loaded it one event too late
  -- and it silently never attached to the first file opened in a session
  -- (confirmed empirically: git gutter signs never appeared for buffer 1).
  -- BufReadPre fires earliest, so every plugin here — whichever of
  -- BufRead/BufReadPost/FileType it listens on — still catches its own
  -- event normally afterwards. Verified treesitter highlighting, illuminate,
  -- indent guides, rainbow delimiters and the git gutter all now attach
  -- correctly to the very first file opened in a fresh session.
  -- gitsigns.nvim replaced vim-signify here: same sign-column git markers,
  -- plus hunk stage/reset/preview/blame (see lua/plugins/gitsigns.lua).
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('plugins.gitsigns')
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('plugins.indent-blankline')
    end,
  },
  { 'andymass/vim-matchup', event = { 'BufReadPre', 'BufNewFile' } },
  -- auto-pairs/closetag/tagalong all set up their (buffer-local) mappings
  -- from a FileType/BufEnter-ish autocmd of their own, which — like
  -- signify above — has already passed by the time you first enter insert
  -- mode in that same buffer if loaded on InsertEnter instead: confirmed
  -- typing `(` right after opening a file did nothing (no closing paren)
  -- until this was changed to the earlier BufReadPre/BufNewFile group.
  { 'jiangmiao/auto-pairs', event = { 'BufReadPre', 'BufNewFile' } },
  { 'alvan/vim-closetag', event = { 'BufReadPre', 'BufNewFile' } },
  { 'tpope/vim-surround', lazy = false },
  { 'AndrewRadev/tagalong.vim', event = { 'BufReadPre', 'BufNewFile' } },
  { 'neoclide/coc.nvim', lazy = false, branch = 'master', build = 'yarn install --frozen-lockfile' },
  { 'tpope/vim-fugitive', lazy = false },
  { 'mg979/vim-visual-multi', lazy = false, branch = 'master' },

  -- Syntax Highlighting & Code Navigation
  { 'RRethy/vim-illuminate', event = { 'BufReadPre', 'BufNewFile' } },
  {
    'HiPhish/rainbow-delimiters.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('plugins.rainbow-delimiters')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      require('plugins.treesitter')
    end,
  },
  -- CSS-in-JS syntax, only relevant to these filetypes.
  {
    'styled-components/vim-styled-components',
    branch = 'main',
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css' },
  },
  { 'honza/vim-snippets', event = 'InsertEnter' },
  { 'folke/flash.nvim', lazy = false },
  -- Shows a popup of available keybindings when you pause mid-combo
  -- (leader, g, ], [...). VeryLazy = load shortly after startup finishes,
  -- not blocking the first frame, but ready well before you'd pause on a key.
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('plugins.which-key')
    end,
  },

  -- Comments
  { 'preservim/nerdcommenter', lazy = false },

  -- Code screenshots (polacode-style). Loads its ~50ms native generator
  -- library only on first use, not on every startup.
  {
    'mistricky/codesnap.nvim',
    tag = 'v2.0.5',
    keys = {
      { '<leader>cs', ':CodeSnap<CR>', mode = 'x', desc = 'CodeSnap to clipboard' },
      {
        '<leader>cS',
        function()
          local save_dir = vim.fn.expand('~/Pictures/CodeSnap')
          vim.fn.mkdir(save_dir, 'p')
          local path = save_dir .. '/CodeSnap_' .. os.date('%Y-%m-%d_%H-%M-%S') .. '.png'
          vim.cmd("'<,'>CodeSnapSave " .. path)
        end,
        mode = 'x',
        desc = 'CodeSnap to file',
      },
    },
    cmd = { 'CodeSnap', 'CodeSnapSave' },
    config = function()
      require('plugins.codesnap')
    end,
  },
}
