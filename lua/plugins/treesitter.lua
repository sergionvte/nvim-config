-- nvim-treesitter (main branch, 2024+ rewrite): the old `.configs.setup{}` API
-- was removed. Parsers are installed explicitly and highlighting/indent are
-- enabled per-filetype via autocmds instead of a single setup() call.
local ensure_installed = { "javascript", "typescript", "tsx", "html", "css", "json", "lua", "python", "java", "go", "gomod", "gowork", "gosum" }

require('nvim-treesitter').install(ensure_installed)

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "css", "json", "lua", "python", "java", "go", "gomod", "gowork", "gosum" },
  callback = function()
    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
