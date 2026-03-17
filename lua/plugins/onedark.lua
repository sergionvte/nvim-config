require('onedark').setup({
  style = 'darker',
  toggle_style_key = '<leader>ts',
  ending_tildes = true,
  diagnostics = {
    darker = true,
    background = true,
  },
  transparent = true,  -- Fondo del editor transparente
})

require('onedark').load()

-- Fondo solo para nvim-tree (usa el color darker del tema)
local bg = require('onedark.palette').darker.bg0
vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = bg })
vim.api.nvim_set_hl(0, 'NvimTreeEndOfBuffer', { bg = bg })
