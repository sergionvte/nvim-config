-- Ctrl+F salta a cualquier posición visible en pantalla escribiendo 1-2
-- letras (como easymotion/hop, pero integrado con treesitter). Útil para
-- moverse largas distancias sin contar líneas.
require("flash").setup({
  -- Configuración básica
})

-- Mapear Ctrl+f para iniciar la búsqueda con flash.nvim en modos Normal, Visual y Operator-pending
vim.keymap.set({"n", "x", "o"}, "<C-f>", function()
  require("flash").jump()
end, { desc = "Flash Jump (Search)" })
