-- settings.lua
-- Define leader key
vim.g.mapleader = '\\'

-- Editor settings
vim.o.expandtab = true
vim.o.mouse = 'a'
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.showmode = false
vim.o.clipboard = 'unnamedplus'
vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hidden = true
vim.o.cursorline = true
vim.o.updatetime = 300

vim.cmd [[
  autocmd FileType python setlocal tabstop=4 shiftwidth=4
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
  autocmd BufWritePre * :%s/\s\+$//e
]]

-- Mappings
vim.api.nvim_set_keymap('n', '<Space>', ':', { noremap = true })
vim.api.nvim_set_keymap('n', 'w', 'e', { noremap = true })
vim.api.nvim_set_keymap('n', 'e', 'w', { noremap = true })
vim.api.nvim_set_keymap('n', '<silent>//', ':nohlsearch<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'ñ', '$', { noremap = true })
vim.api.nvim_set_keymap('n', 'Ñ', '0', { noremap = true })
vim.api.nvim_set_keymap('n', 'J', 'G', { noremap = true })
vim.api.nvim_set_keymap('n', 'K', 'gg', { noremap = true })
vim.api.nvim_set_keymap('n', ',,', 'ciw', { noremap = true })
vim.api.nvim_set_keymap('n', '..', 'diw', { noremap = true })
vim.api.nvim_set_keymap('n', '--', 'cs', { noremap = true })
vim.api.nvim_set_keymap('v', 'w', 'e', { noremap = true })
vim.api.nvim_set_keymap('v', 'e', 'w', { noremap = true })
vim.api.nvim_set_keymap('v', 'ñ', '$', { noremap = true })
vim.api.nvim_set_keymap('v', '\'', '$', { noremap = true })
vim.api.nvim_set_keymap('v', 'J', 'G', { noremap = true })
vim.api.nvim_set_keymap('v', 'K', 'gg', { noremap = true })

-- Function to reload configuration
if not vim.fn.exists('*ReloadConfig') then
  function ReloadConfig()
    vim.cmd('source ~/.config/nvim/init.lua')
  end
end

vim.api.nvim_set_keymap('n', '<leader><leader>', ':lua ReloadConfig()<CR>', { noremap = true, silent = true })
