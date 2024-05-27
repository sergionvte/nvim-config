-- Emmet
vim.g.user_emmet_settings = {
  variables = { lang = 'en' },
  html = {
    default_attributes = {
      option = { value = nil },  -- Reemplaza v.null con nil
      textarea = { id = nil, name = nil, cols = 10, rows = 10 },  -- Reemplaza v.null con nil
    },
    snippets = {
      ['html:5'] = "<!DOCTYPE html>\n<html lang=\"${lang}\">\n<head>\n\t<meta charset=\"${charset}\">\n\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n\t<title></title>\n</head>\n<body>\n\t${child}|\n</body>\n</html>",
    },
  },
}
