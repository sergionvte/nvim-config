require('codesnap').setup({
  show_workspace = false,
  snapshot_config = {
    theme = 'onedarkpro',
    themes_folders = { vim.fn.expand('~/.config/codesnap/remote_themes') },
    watermark = {
      content = '',
    },
    background = {
      stops = {
        { position = 0, color = '#00000000' },
        { position = 1, color = '#00000000' },
      },
    },
    window = {
      margin = {
        x = 20,
        y = 20,
      },
    },
    code_config = {
      font_family = 'FiraCode Nerd Font Mono',
      breadcrumbs = {
        enable = false,
      },
    },
  },
})

-- Keymaps for this live in lua/plugins/spec.lua (lazy.nvim's `keys`), so the
-- plugin — and its ~50ms native generator library — only loads the first
-- time you actually press <leader>cs / <leader>cS, not on every startup.
