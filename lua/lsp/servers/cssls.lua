local config = require('lsp.config')

local server = config.make({
  cmd = {'vscode-css-language-server', '--stdio'},
  name = 'cssls',
  filetypes = {
    'css',
    'scss',
    'less'
  },
})

return server

