require('auto-save').setup({
  enabled = true,
  execution_message = {
    message = '',   -- Sin mensaje al guardar (equivalente a auto_save_silent)
  },
  trigger_events = { 'InsertLeave', 'TextChanged' },
})