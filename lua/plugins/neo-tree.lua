-- vim.g.loaded_netrw ya se define en lua/plugins/spec.lua (su `init`, que
-- corre antes de que el plugin cargue) — no repetirlo acá.

-- vim.ui.input() (usado por use_popups_for_input=false más abajo) deja el
-- cursor al FINAL del texto precargado por defecto — molesto para el caso
-- común de anteponer algo (../, otra carpeta) en vez de editar la
-- extensión. Metiendo un <Home> en el typeahead justo antes de abrir el
-- prompt, el cursor arranca al principio sin tocar nada más del prompt.
-- No afecta a otros usos de vim.ui.input sin `default` (p. ej. gitsigns).
local default_ui_input = vim.ui.input
vim.ui.input = function(opts, on_confirm)
  if opts and opts.default and opts.default ~= '' then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Home>', true, false, true), 'n', false)
  end
  default_ui_input(opts, on_confirm)
end

require('neo-tree').setup({
  close_if_last_window = true,
  popup_border_style = 'rounded',
  -- The default rename/create popup is a tiny floating box positioned
  -- relative to the cursor, fixed-width to the prompt text (no wrapping)
  -- and re-anchored with negative offsets to avoid overflowing the screen
  -- — since the tree is docked at the far right edge, that math constantly
  -- has to yank it back onto the screen, which is the "jumps out of the
  -- window" effect. vim.ui.input() instead prompts on the cmdline: always
  -- the same spot at the bottom, full width, no jumping.
  use_popups_for_input = false,
  default_component_configs = {
    indent = {
      indent_size = 1,
      with_markers = true,
      -- Same folder expand/collapse arrow nvim-tree showed (its
      -- renderer.icons.glyphs.folder.arrow_closed/open); off by default here.
      with_expanders = true,
    },
  },
  -- Igual que en nvim-tree: abrir un archivo cierra el árbol; entrar a una
  -- carpeta sólo la expande, así que este evento (que sólo dispara para
  -- archivos, nunca para directorios) alcanza sin tocar los mappings de <cr>.
  event_handlers = {
    {
      event = 'file_open_requested',
      handler = function()
        require('neo-tree.command').execute({ action = 'close' })
      end,
    },
  },
  window = {
    width = 30,
    position = 'right',
  },
  filesystem = {
    hijack_netrw_behavior = 'open_default',
    filtered_items = {
      -- hide_dotfiles stays at its default (true) and visible=true shows
      -- them anyway from the start — `H` toggles `visible`, which only has
      -- anything to show/hide when a category is actually marked as
      -- filtered. Setting hide_dotfiles=false instead (nvim-tree style)
      -- would make `H` a permanent no-op for dotfiles, since there'd be
      -- nothing left for it to toggle.
      visible = true,
      hide_gitignored = false,
    },
    follow_current_file = {
      enabled = true,
    },
  },
})

-- <C-n>/<C-b>/<leader>n ya están mapeados en lua/plugins/spec.lua (su
-- `keys`, que es justamente lo que dispara la carga de este archivo).

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'neo-tree',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    vim.opt_local.foldcolumn = '0'
    vim.opt_local.statuscolumn = ''
    vim.opt_local.scrolloff = 0
  end,
})
