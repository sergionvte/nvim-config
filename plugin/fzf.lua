-- Fzf
vim.api.nvim_set_keymap('n', '<C-m>', ':Buffer<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-a>', ':Ag<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-z>', ':Files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-h>', ':Ag<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-l>', ':Files<CR>', { noremap = true, silent = true })
