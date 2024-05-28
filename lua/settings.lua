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
vim.o.ignorecase = true  -- Ignorar mayúsculas y minúsculas en búsquedas
vim.o.smartcase = true   -- No ignorar si la búsqueda contiene mayúsculas
vim.o.incsearch = true   -- Búsqueda incremental
vim.o.hlsearch = true    -- Resaltar coincidencias

vim.cmd [[
  autocmd FileType python setlocal tabstop=4 shiftwidth=4
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
  autocmd BufWritePre * :%s/\s\+$//e
]]
