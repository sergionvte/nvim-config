-- everforest.lua

-- Configuración del tema Everforest
vim.g.everforest_background = 'hard'
vim.g.everforest_enable_italic = 1
vim.g.everforest_enable_bold = 1
vim.g.everforest_transparent_background = 1
vim.g.everforest_current_word = 'grey background'

-- Configuración de Lightline (si estás utilizando Lightline como tu barra de estado)
vim.g.lightline = { colorscheme = 'everforest' }

-- Habilitar colores de terminal verdaderos si son compatibles
if vim.fn.has('termguicolors') == 1 then
    vim.o.termguicolors = true
end

-- Establecer el fondo del editor como oscuro
vim.o.background = 'dark'

-- Establecer el esquema de color
vim.cmd('colorscheme everforest')

