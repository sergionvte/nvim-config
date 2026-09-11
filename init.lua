-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- vim-visual-multi reads g:VM_maps once, eagerly, when it loads below — so
-- this must be set before require('lazy').setup(), not in editor.vim (which
-- is sourced later and previously made these settings silently no-op).
-- Multicursor style like VSCode:
--   alt+j / alt+k -> add a cursor on the line below/above
--   alt+d         -> add a cursor at the next match of the word/selection
-- (Previously this same functionality also fought with coc-cursors over the
-- exact same <C-A-Down>/<C-A-Up> keys; that duplicate mapping is removed.
-- Ctrl+Alt+j/k/d was tried too, but collided with plain <C-j>/<C-k> (fzf
-- Ag/Files) because iTerm2's Option key wasn't sending Esc+, so Ctrl won and
-- Alt was silently dropped — fixed at the iTerm2 profile level instead.)
vim.g.VM_default_mappings = 0
vim.g.VM_maps = {
  ['Find Under'] = '<M-d>',
  ['Find Subword Under'] = '<M-d>',
  ['Add Cursor Down'] = '<M-j>',
  ['Add Cursor Up'] = '<M-k>',
  ['Skip Region'] = '<C-x>',
}

if not _G.__lazy_setup_done then
  require('lazy').setup(require('plugins.spec'))
  _G.__lazy_setup_done = true
end

vim.g.python3_host_prog = '/usr/bin/python3'

-- Editor settings (Vimscript — keymaps, options)
vim.cmd('source ~/.config/nvim/editor.vim')

-- Plugins settings (Vimscript — non-lua plugins)
vim.cmd('source ~/.config/nvim/plugins.vim')

-- Lua plugins (nvim-tree, lualine, onedark, bufferline, auto-save)
pcall(require, 'plugins.nvim-tree')
pcall(require, 'plugins.lualine')
pcall(require, 'plugins.onedark')
pcall(require, 'plugins.autosave')
pcall(require, 'plugins.bufferline')
pcall(require, 'plugins.treesitter')
pcall(require, 'plugins.indent-blankline')
pcall(require, 'config.autocmds')
pcall(require, 'plugins.flash')
pcall(require, 'plugins.codesnap')
pcall(require, 'plugins.rainbow-delimiters')
pcall(require, 'config.healthcheck')
