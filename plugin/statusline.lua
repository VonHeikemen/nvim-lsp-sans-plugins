if vim.g.loaded_statusline == 1 then
  return
end

vim.g.loaded_statusline = 1
require('user.statusline').setup()

