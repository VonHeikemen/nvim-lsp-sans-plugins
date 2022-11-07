if vim.g.loaded_toggle_terminal == 1 then
  return
end

vim.g.loaded_toggle_terminal = 1

require('user.terminal').setup()

