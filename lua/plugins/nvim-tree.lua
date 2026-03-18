-- Deshabilitar netrw (requerido por nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
  hijack_cursor = true,
  sync_root_with_cwd = true,
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')
    api.config.mappings.default_on_attach(bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }
    vim.keymap.set('n', '<CR>', function()
      local node = api.tree.get_node_under_cursor()
      if node.type == 'file' then
        api.node.open.edit()
        api.tree.close()
      else
        api.node.open.edit()
      end
    end, opts)
  end,
  view = {
    width = 30,
    side = 'right',
    signcolumn = 'no'
  },
  renderer = {
    highlight_git = true,
    highlight_opened_files = 'name',
    indent_width = 1,
    root_folder_label = false,
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        folder = {
          arrow_closed = '',
          arrow_open = '',
        },
      },
    },
  },
  hijack_directories = {
    enable = true,
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
  },
})

-- Keymaps
vim.keymap.set('n', '<leader>n', ':NvimTreeFocus<CR>', { silent = true })
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.statuscolumn = ""
    vim.opt_local.scrolloff = 0
    vim.cmd('SignifyDisableAll')
  end,
})
