require('onedark').setup({
  style = 'darker',
  toggle_style_key = '<leader>ts',
  ending_tildes = true,
  diagnostics = {
    darker = true,
    background = true,
  },
  transparent = true,
})
require('onedark').load()

vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'NvimTreeNormalNC', { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'NvimTreeEndOfBuffer', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'NvimTreeCursorLine', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'NvimTreeWinSeparator', { fg = 'NONE', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = 'NONE', bg = 'NONE' })
