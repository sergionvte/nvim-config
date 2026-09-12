-- Replaces vim-signify: same idea (mark added/changed/deleted lines in the
-- sign column against git HEAD), plus hunk-level actions (stage, reset,
-- preview, blame) that signify didn't have.
require('gitsigns').setup({
  signs = {
    add = { text = '│' },
    change = { text = '│' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = require('gitsigns')
    local opts = { buffer = bufnr, silent = true }

    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(gs.next_hunk)
      return '<Ignore>'
    end, vim.tbl_extend('force', opts, { expr = true, desc = 'Next git hunk' }))

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(gs.prev_hunk)
      return '<Ignore>'
    end, vim.tbl_extend('force', opts, { expr = true, desc = 'Previous git hunk' }))

    vim.keymap.set('n', '<leader>gs', gs.stage_hunk, vim.tbl_extend('force', opts, { desc = 'Stage hunk' }))
    vim.keymap.set('n', '<leader>gr', gs.reset_hunk, vim.tbl_extend('force', opts, { desc = 'Reset hunk' }))
    vim.keymap.set('n', '<leader>gp', gs.preview_hunk, vim.tbl_extend('force', opts, { desc = 'Preview hunk' }))
    vim.keymap.set('n', '<leader>gb', gs.toggle_current_line_blame, vim.tbl_extend('force', opts, { desc = 'Toggle line blame' }))
  end,
})

-- Same transparent-friendly treatment as the NvimTree/SignColumn highlights
-- in onedark.lua.
vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#00ff00', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#ffff00', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#ff0000', bg = 'NONE' })
