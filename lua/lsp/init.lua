local M = {}

local lsp = require('lsp.client')

require('lsp.configs.shared').setup()

M.project_setup = function(list)
  for _, server in pairs(list) do
    lsp.start(server)
  end
end

M.start = lsp.start

return M

