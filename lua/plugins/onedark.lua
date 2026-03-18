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

local bg = require('onedark.palette').darker.bg0
vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = bg })
vim.api.nvim_set_hl(0, 'NvimTreeEndOfBuffer', { bg = bg })
vim.api.nvim_set_hl(0, 'NvimTreeCursorLine', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = bg, bg = bg })
