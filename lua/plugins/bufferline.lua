require('bufferline').setup({
  options = {
    mode = 'buffers',
    separator_style = 'thin',
    always_show_bufferline = false,
    show_buffer_close_icons = true,
    show_close_icon = false,
    color_icons = true,
    close_icon = '×',
    close_command = 'bdelete! %d',
    right_mouse_command = 'bdelete! %d',
    indicator = {
      style = 'none',   -- Quita la línea del buffer activo
    },
    offsets = {
      {
        filetype = 'NvimTree',
        text = '',
        padding = 0,
      },
    },
  },

  highlights = {
    fill = { bg = 'NONE' },
    background = { bg = 'NONE' },
    buffer_selected = {
      bold = true,
      italic = true,
      bg = require('onedark.palette').darker.bg2,
    },
    numbers_selected = { bg = require('onedark.palette').darker.bg2 },
    close_button_selected = { bg = require('onedark.palette').darker.bg2 },
    diagnostic_selected = { bg = require('onedark.palette').darker.bg2 },
    hint_selected = { bg = require('onedark.palette').darker.bg2 },
    info_selected = { bg = require('onedark.palette').darker.bg2 },
    warning_selected = { bg = require('onedark.palette').darker.bg2 },
    error_selected = { bg = require('onedark.palette').darker.bg2 },
    modified_selected = { bg = require('onedark.palette').darker.bg2 },
    separator = { fg = require('onedark.palette').darker.bg2, bg = 'NONE' },
    separator_selected = { fg = require('onedark.palette').darker.bg2, bg = 'NONE' },
    separator_visible = { fg = require('onedark.palette').darker.bg2, bg = 'NONE' },
    offset_separator = { fg = require('onedark.palette').darker.bg2, bg = 'NONE' },
  },
})
