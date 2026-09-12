-- Custom silent autosave (auto-save.nvim used to be a dependency here, but
-- it enabled itself by default before this file's config even ran — a
-- load-order quirk in the plugin — and its before/after-saving callbacks
-- weren't reliable either, so it was dropped entirely). After a period of
-- inactivity, `:noautocmd write` saves the file without firing BufWritePre
-- — meaning no formatting, no trailing-whitespace trim. Those only happen
-- on an explicit, manual `:w`, which runs normally with autocmds enabled.

local inactivity_ms = 2000
local timer = nil

local function try_silent_save()
  local buf = vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end
  if vim.bo[buf].buftype ~= '' then
    return
  end
  if vim.bo[buf].filetype == 'NvimTree' then
    return
  end
  if not vim.bo[buf].modifiable or not vim.bo[buf].modified then
    return
  end
  if vim.api.nvim_buf_get_name(buf) == '' then
    return
  end

  vim.api.nvim_buf_call(buf, function()
    vim.cmd('silent! noautocmd write')
  end)
end

local function schedule_silent_save()
  if timer then
    timer:stop()
    timer:close()
  end
  timer = vim.loop.new_timer()
  timer:start(inactivity_ms, 0, vim.schedule_wrap(try_silent_save))
end

vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
  pattern = '*',
  callback = schedule_silent_save,
})
