if vim.g.loaded_tabline == 1 then
  return
end

vim.g.loaded_tabline = 1
require('user.tabline').setup()

