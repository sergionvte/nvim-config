-- Chequeo de herramientas externas por lenguaje, bajo demanda. Pensado para
-- cuando cambies de máquina: si abres un archivo de un lenguaje al que le
-- falta algo (compilador, LSP, formateador), te avisa una vez; si abres uno
-- que sí tiene todo instalado, no dice absolutamente nada.
local M = {}

-- filetype -> { nombre a mostrar, binarios que requiere }
local checks = {
  python = { name = 'Python', bins = { 'python3', 'black' } },
  javascript = { name = 'JavaScript/TypeScript', bins = { 'node' } },
  typescript = { name = 'JavaScript/TypeScript', bins = { 'node' } },
  javascriptreact = { name = 'JavaScript/TypeScript', bins = { 'node' } },
  typescriptreact = { name = 'JavaScript/TypeScript', bins = { 'node' } },
  java = { name = 'Java', bins = { 'java' } },
  go = { name = 'Go', bins = { 'go', 'gopls' } },
  kotlin = { name = 'Kotlin', bins = { 'kotlinc', 'kotlin-language-server' } },
}

local function missing_bins(lang)
  local missing = {}
  for _, bin in ipairs(lang.bins) do
    if vim.fn.executable(bin) == 0 then
      table.insert(missing, bin)
    end
  end
  return missing
end

-- Evita repetir el mismo aviso cada vez que abres otro archivo del mismo lenguaje.
local notified = {}

local function check_filetype(ft)
  local lang = checks[ft]
  if not lang or notified[lang.name] then
    return
  end

  local missing = missing_bins(lang)
  if #missing > 0 then
    notified[lang.name] = true
    vim.notify(
      'Faltan herramientas de ' .. lang.name .. ': ' .. table.concat(missing, ', '),
      vim.log.levels.WARN,
      { title = 'Neovim: herramienta faltante' }
    )
  end
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = vim.tbl_keys(checks),
  callback = function(args)
    check_filetype(vim.bo[args.buf].filetype)
  end,
})

-- :CheckTools sigue revisando todos los lenguajes de una, para cuando
-- quieras confirmar manualmente el estado completo (p. ej. tras instalar algo).
vim.api.nvim_create_user_command('CheckTools', function()
  local seen = {}
  local report = {}
  for _, lang in pairs(checks) do
    if not seen[lang.name] then
      seen[lang.name] = true
      local missing = missing_bins(lang)
      if #missing > 0 then
        table.insert(report, lang.name .. ': ' .. table.concat(missing, ', '))
      end
    end
  end

  if #report > 0 then
    vim.notify('Faltan herramientas para:\n  ' .. table.concat(report, '\n  '), vim.log.levels.WARN, { title = 'Neovim: herramientas faltantes' })
  else
    vim.notify('Todas las herramientas están instaladas.', vim.log.levels.INFO, { title = 'Neovim: herramientas' })
  end
end, {})

return M
