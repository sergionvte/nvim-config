-- Ctrl+F salta a cualquier posición visible en pantalla escribiendo 1-2
-- letras (como easymotion/hop, pero integrado con treesitter). Útil para
-- moverse largas distancias sin contar líneas. El mapeo de Ctrl+f vive en
-- lua/plugins/spec.lua (su `keys`, que es justamente lo que dispara la
-- carga de este archivo) en vez de acá, para que lazy.nvim no tenga que
-- cargar el plugin entero sólo para poder registrar el atajo.
require('flash').setup({
  -- Configuración básica
})
