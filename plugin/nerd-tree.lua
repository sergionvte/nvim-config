-- NERDTree
vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeShowHidden = 1
vim.cmd [[
  autocmd VimEnter * if !argc() | execute 'NERDTree' | wincmd p | q | endif
]]
vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeFocus<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
