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
  -- Replaces nvim-tree: same sidebar-on-the-right idea, but with git status
  -- (add/modify/etc.) rendered inline per-file and multiple sources
  -- (filesystem/buffers/git status) in the same tree.
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<C-n>', '<cmd>Neotree toggle<CR>', desc = 'Toggle file tree' },
      { '<C-b>', '<cmd>Neotree toggle<CR>', desc = 'Toggle file tree' },
      { '<leader>n', '<cmd>Neotree focus<CR>', desc = 'Focus file tree' },
    },
    cmd = 'Neotree',
    init = function()
      -- Must run before neo-tree loads, so it can't live in the lazy-loaded config module.
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      require('plugins.neo-tree')
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
  -- Colors only matter once there's a buffer with something to highlight,
  -- so it follows the same BufReadPre/BufNewFile reasoning as the Editing
  -- Enhancements group below.
  {
    'rrethy/vim-hexokinase',
    event = { 'BufReadPre', 'BufNewFile' },
    build = vim.fn.has('win32') == 0 and 'make hexokinase' or nil,
  },
  -- always_show_bufferline=false (see lua/plugins/bufferline.lua) already
  -- means it renders nothing until a 2nd buffer is open, so deferring its
  -- load to the same BufReadPre/BufNewFile event as the group below costs
  -- nothing visible while skipping the load entirely on a startup that
  -- never opens a second buffer.
  {
    'akinsho/bufferline.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('plugins.bufferline')
    end,
  },

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
  -- coc.nvim is the single heaviest eager plugin here (LSP client +
  -- completion + diagnostics) — like gitsigns/treesitter/etc. above, it
  -- only does anything once a real buffer exists, so the same
  -- BufReadPre/BufNewFile trigger applies. g:coc_user_config (see
  -- lua/config/coc_portable.lua) is set in init.lua before
  -- require('lazy').setup() regardless of when coc itself ends up loading,
  -- so this doesn't reopen that load-order gotcha.
  {
    'neoclide/coc.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    branch = 'master',
    build = 'yarn install --frozen-lockfile',
  },
  -- Not referenced by any keymap (see README) — every fugitive feature is
  -- reached through its own :G/:Git-family commands, so cmd-based lazy
  -- loading covers all of it.
  {
    'tpope/vim-fugitive',
    cmd = { 'G', 'Git', 'Gdiffsplit', 'Gvdiffsplit', 'Gread', 'Gwrite', 'Gedit' },
  },
  -- g:VM_maps (init.lua) is read once when vim-visual-multi's own plugin/
  -- script loads — same as coc's g:coc_user_config above, that's set well
  -- before require('lazy').setup() regardless of *when* this actually
  -- loads, so triggering on the exact keys that start a multicursor
  -- session (Alt+j/k/d) is safe. <C-x> (Skip Region) isn't included: that
  -- one only does anything *during* an already-active multicursor session
  -- — outside of one it's the regular "close buffer" mapping (see README),
  -- so it must never be what loads this plugin.
  {
    'mg979/vim-visual-multi',
    branch = 'master',
    keys = { '<M-j>', '<M-k>', '<M-d>' },
  },

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
  -- Jump-to-anywhere-on-screen motion, only relevant once you press its own
  -- trigger key — same idea as codesnap below, `keys` both defers loading
  -- and *is* the real mapping (no separate vim.keymap.set needed elsewhere).
  {
    'folke/flash.nvim',
    keys = {
      {
        '<C-f>',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash Jump (Search)',
      },
    },
    config = function()
      require('plugins.flash')
    end,
  },
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
