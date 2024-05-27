-- gruvbox_material.lua

-- Configuración del tema Gruvbox Material
vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_foreground = 'material'
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_ui_contrast = 'high'
vim.g.gruvbox_spell_foreground = 'colored'
vim.g.gruvbox_material_current_word = 'grey background'

-- Configuración de Lightline (si estás utilizando Lightline como tu barra de estado)
vim.g.lightline = { colorscheme = 'gruvbox_material' }

-- Habilitar colores de terminal verdaderos si son compatibles
if vim.fn.has('termguicolors') == 1 then
    vim.o.termguicolors = true
end

-- Establecer el fondo del editor como oscuro
vim.o.background = 'dark'

-- Establecer el esquema de color
vim.cmd('colorscheme gruvbox-material')
