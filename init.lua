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

-- Same load-order concern as VM_maps above: nerdcommenter checks
-- g:NERDCreateDefaultMappings once, eagerly, when it loads below, and
-- creates its default mappings (e.g. <leader>cs for "Sexy Comment") right
-- there if it's not already 0 by then — setting it in plugins.vim (sourced
-- later) was too late to stop that, it just happened to go unnoticed because
-- CodeSnap's own <leader>cs mapping used to be set even later and clobbered
-- it. Lazy-loading CodeSnap surfaced the conflict.
vim.g.NERDCreateDefaultMappings = 0

-- Same load-order concern as VM_maps above: coc.nvim reads g:coc_user_config
-- when it loads below, so the OS-dependent LSP paths this computes (gopls,
-- kotlin-language-server, JDK home — see the module itself) must be set
-- before require('lazy').setup(), not after.
pcall(require, 'config.coc_portable')

if not _G.__lazy_setup_done then
  require('lazy').setup(require('plugins.spec'))
  _G.__lazy_setup_done = true
end

-- Let Neovim find python3 on $PATH itself (works the same on macOS, Linux
-- and Windows) instead of hardcoding a Unix path here.
if vim.fn.executable('python3') == 1 then
  vim.g.python3_host_prog = vim.fn.exepath('python3')
end

-- Editor settings (Vimscript — keymaps, options)
local config_dir = vim.fn.stdpath('config')
vim.cmd('source ' .. config_dir .. '/editor.vim')

-- Plugins settings (Vimscript — non-lua plugins)
vim.cmd('source ' .. config_dir .. '/plugins.vim')

-- Lua plugins (lualine, onedark, bufferline, auto-save). nvim-tree and
-- codesnap are NOT required here — lazy.nvim loads them (and calls their
-- config modules itself) only on first use, via `keys`/`cmd` in spec.lua.
pcall(require, 'plugins.lualine')
pcall(require, 'plugins.onedark')
pcall(require, 'plugins.autosave')
pcall(require, 'plugins.bufferline')
pcall(require, 'plugins.treesitter')
pcall(require, 'plugins.indent-blankline')
pcall(require, 'config.autocmds')
pcall(require, 'plugins.flash')
pcall(require, 'plugins.rainbow-delimiters')
pcall(require, 'config.healthcheck')
pcall(require, 'config.run_file')
