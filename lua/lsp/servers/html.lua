local config = require('lsp.config')

local server = config.make({
  cmd = {'vscode-html-language-server', '--stdio'},
  name = 'html',
  filetypes = {'html'},
})

return server

