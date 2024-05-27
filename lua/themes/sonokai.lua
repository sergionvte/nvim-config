-- sonokai.lua

-- Configuración del tema Sonokai
vim.g.sonokai_style = 'default'
vim.g.sonokai_enable_italic = 1
vim.g.sonokai_enable_bold = 1
vim.g.sonokai_transparent_background = 1
vim.g.sonokai_current_word = 'underline'

-- Configuración de Lightline (si estás utilizando Lightline como tu barra de estado)
vim.g.lightline = { colorscheme = 'sonokai' }

-- Habilitar colores de terminal verdaderos si son compatibles
if vim.fn.has('termguicolors') == 1 then
    vim.o.termguicolors = true
end

-- Establecer el fondo del editor como oscuro
vim.o.background = 'dark'

-- Establecer el esquema de color
vim.cmd('colorscheme sonokai')
