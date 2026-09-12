-- Guías verticales de indentación, más una guía resaltada (scope) que marca
-- el bloque de código donde está el cursor.
require('ibl').setup({
  indent = { char = '│' },
  scope = {
    enabled = true,
    show_start = false,
    show_end = false,
    include = {
      -- ibl's built-in list for python only covers class/def/comprehensions.
      -- Python's grammar uses a single generic `block` node for the body of
      -- every compound statement (for/if/elif/else/while/with/try/except/
      -- finally/def/class), so including it covers all of them at once.
      node_type = {
        python = { 'block' },
      },
    },
  },
  exclude = {
    filetypes = { 'NvimTree', 'help', 'dashboard' },
    buftypes = { 'nofile', 'terminal', 'quickfix' },
  },
})
