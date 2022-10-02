-- Augroup for user created autocommands
vim.api.nvim_create_augroup('user_cmds', {clear = true})

-- Make sure user modules can be reloaded when using :source
local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

-- Editor settings
load('user.settings')

-- Awesome keybindings
load('user.keymaps')

-- Netrw customizations
load('user.netrw')

-- Session helper
load('user.sessions')

-- Set lsp commands
require('lsp.commands')

