-- mappings.lua

-- Mappings
vim.api.nvim_set_keymap('n', '<Space>', ':', { noremap = true })
vim.api.nvim_set_keymap('n', 'w', 'e', { noremap = true })
vim.api.nvim_set_keymap('n', 'e', 'w', { noremap = true })
vim.api.nvim_set_keymap('n', 'ñ', '$', { noremap = true })
vim.api.nvim_set_keymap('n', 'Ñ', '0', { noremap = true })
vim.api.nvim_set_keymap('n', 'J', 'G', { noremap = true })
vim.api.nvim_set_keymap('n', 'K', 'gg', { noremap = true })
vim.api.nvim_set_keymap('n', ',,', 'ciw', { noremap = true })
vim.api.nvim_set_keymap('n', '..', '#', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'w', 'e', { noremap = true })
vim.api.nvim_set_keymap('v', 'e', 'w', { noremap = true })
vim.api.nvim_set_keymap('v', 'ñ', '$', { noremap = true })
vim.api.nvim_set_keymap('v', '\'', '$', { noremap = true })
vim.api.nvim_set_keymap('v', 'J', 'G', { noremap = true })
vim.api.nvim_set_keymap('v', 'K', 'gg', { noremap = true })
vim.api.nvim_set_keymap('n', '//', ':noh<CR>', { noremap = true, silent = true })
-- Invertir el comportamiento de n y N después de una búsqueda
