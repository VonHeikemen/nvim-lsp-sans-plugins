local shared = require('lsp.configs.shared')

local filetypes = {'html'}

local server = shared.make_config({
  cmd = {'vscode-html-language-server', '--stdio'},
  name = 'html',
  filetypes = filetypes,
})

return server

