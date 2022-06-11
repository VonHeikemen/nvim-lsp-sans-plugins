local shared = require('lsp.configs.shared')

local filetypes = {
  'css',
  'scss',
  'less'
}

local server = shared.make_config({
  cmd = {'vscode-css-language-server', '--stdio'},
  name = 'cssls',
  filetypes = filetypes,
})

return server

