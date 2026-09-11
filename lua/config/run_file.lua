-- Ctrl+Enter (auto-close) / Ctrl+Alt+Enter (persistente) para correr el
-- archivo actual en un split de terminal, por lenguaje. Antes esto era
-- VimScript con `python3` y una ruta /tmp fijas — python3 no siempre existe
-- en Windows (suele ser solo `python`), y /tmp tampoco existe ahí, así que
-- ambas cosas se resuelven en tiempo de ejecución.
local function python_cmd()
  if vim.fn.executable('python3') == 1 then
    return 'python3'
  end
  return 'python'
end

local runners = {
  python = function()
    return python_cmd() .. ' %'
  end,
  javascript = function()
    return 'node %'
  end,
  typescript = function()
    return 'node %'
  end,
  java = function()
    return 'java %'
  end,
  go = function()
    return 'go run %'
  end,
  kotlin = function()
    local jar = vim.fn.fnameescape(vim.fn.stdpath('cache') .. '/nvim_kotlin_run.jar')
    return 'kotlinc % -include-runtime -d ' .. jar .. ' && java -jar ' .. jar
  end,
}

local function run(persistent)
  local builder = runners[vim.bo.filetype]
  if not builder then
    return
  end

  vim.cmd('write')
  vim.cmd('split | terminal ' .. builder())

  if not persistent then
    vim.bo.bufhidden = 'wipe'
    vim.api.nvim_create_autocmd('BufLeave', {
      buffer = 0,
      once = true,
      command = 'bdelete!',
    })
  end

  vim.cmd('startinsert')
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = vim.tbl_keys(runners),
  callback = function(args)
    vim.keymap.set('n', '<C-CR>', function()
      run(false)
    end, { buffer = args.buf, desc = 'Run current file (auto-close)' })
    vim.keymap.set('n', '<C-A-CR>', function()
      run(true)
    end, { buffer = args.buf, desc = 'Run current file (persistent)' })
  end,
})
