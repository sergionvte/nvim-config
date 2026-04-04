vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.html",
  callback = function()
    local root = vim.fs.find("manage.py", {
      upward = true,
      path = vim.fn.expand("%:p:h"),
    })
    if #root > 0 then
      vim.bo.filetype = "htmldjango"
    end
  end,
})

-- Format on save using coc.nvim
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
  callback = function()
    if vim.g.format_on_save == 1 or vim.g.format_on_save == true then
      -- pcall prevents throwing errors if formatting fails (e.g., tool not installed)
      pcall(function()
        if vim.fn.exists('*CocAction') == 1 then
          vim.fn.CocAction('format')
        end
      end)
    end
  end,
})
