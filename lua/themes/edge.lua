-- theme.lua

-- Configuración del tema
vim.g.edge_enable_bold = 1
vim.g.edge_transparent_background = 1
vim.g.edge_style = 'aura'
vim.g.edge_ui_contrast = 'default'
vim.g.edge_spell_foreground = 'colored'
vim.g.edge_current_word = 'grey background'

-- Configuración de Lightline (si estás utilizando Lightline como tu barra de estado)
vim.g.lightline = { colorscheme = 'edge' }

-- Habilitar colores de terminal verdaderos si son compatibles
if vim.fn.has('termguicolors') == 1 then
    vim.o.termguicolors = true
end

-- Establecer el fondo del editor como oscuro
vim.o.background = 'dark'

-- Establecer el esquema de color
vim.cmd('colorscheme edge')
