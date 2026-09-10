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

local save_dir = vim.fn.expand('~/Pictures/CodeSnap')

-- Visual mode: `<leader>cs` copies the selection as an image to the clipboard,
-- `<leader>cS` saves it as a timestamped .png in ~/Pictures/CodeSnap.
vim.keymap.set('x', '<leader>cs', ':CodeSnap<CR>', { silent = true, desc = 'CodeSnap to clipboard' })
vim.keymap.set('x', '<leader>cS', function()
  vim.fn.mkdir(save_dir, 'p')
  local path = save_dir .. '/CodeSnap_' .. os.date('%Y-%m-%d_%H-%M-%S') .. '.png'
  vim.cmd("'<,'>CodeSnapSave " .. path)
end, { silent = true, desc = 'CodeSnap to file' })
