-- Tema de color principal de toda la config (lualine, bufferline y
-- rainbow-delimiters reutilizan su paleta via require('onedark.palette')).
-- transparent=true deja que el fondo de la terminal se vea a través de
-- Neovim; por eso SignColumn y los highlights de neo-tree se fuerzan a
-- bg=NONE más abajo, si no fuerzan su propio fondo sólido.
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

local colors = require('onedark.palette').darker
vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'NeoTreeEndOfBuffer', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'NeoTreeCursorLine', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'NeoTreeWinSeparator', { fg = colors.bg2, bg = 'NONE' })
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = colors.bg2, bg = 'NONE' })

-- Signify and SignColumn transparency
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'SignifySignAdd', { fg = '#00ff00', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'SignifySignChange', { fg = '#ffff00', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'SignifySignDelete', { fg = '#ff0000', bg = 'NONE' })
