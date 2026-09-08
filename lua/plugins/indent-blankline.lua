require('ibl').setup({
  indent = { char = '│' },
  scope = { enabled = true, show_start = false, show_end = false },
  exclude = {
    filetypes = { 'NvimTree', 'help', 'dashboard' },
    buftypes = { 'nofile', 'terminal', 'quickfix' },
  },
})
