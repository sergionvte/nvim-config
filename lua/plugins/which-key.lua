-- Muestra un popup con los atajos disponibles cuando te quedás a mitad de
-- una combinación (leader, g, ], [, etc.) — con tantos mapeos custom
-- acumulados en esta config, ayuda a no tener que memorizarlos todos.
-- Usa las descripciones ya puestas en los vim.keymap.set/spec.lua que las
-- tienen; los mapeos en VimScript (editor.vim/plugins.vim) sin `desc`
-- simplemente se muestran con su propio comando en vez de una etiqueta linda.
require('which-key').setup({
  preset = 'modern',
})
