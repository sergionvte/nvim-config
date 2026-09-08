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
