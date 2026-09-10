-- Colorea cada nivel de anidación de (), {} y [] con un color distinto,
-- usando treesitter (a diferencia de luochen1990/rainbow, que usaba :syntax
-- match y nunca llegaba a activarse con el highlighting basado en treesitter
-- de esta config).
local colors = require('onedark.palette').darker

vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = colors.red })
vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = colors.blue })
vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = colors.orange })
vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = colors.green })
vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = colors.cyan })

vim.g.rainbow_delimiters = {
  highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterBlue',
    'RainbowDelimiterOrange',
    'RainbowDelimiterGreen',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan',
  },
}
