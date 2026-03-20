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
