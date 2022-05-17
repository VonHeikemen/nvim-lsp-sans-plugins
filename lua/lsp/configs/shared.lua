local M = {}

local augroup = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})
local autocmd = vim.api.nvim_create_autocmd
local doautocmd = vim.api.nvim_exec_autocmds

M.on_init = function(client, results)
  if results.offsetEncoding then
    client.offset_encoding = results.offsetEncoding
  end

  if client.config.settings then
    client.notify('workspace/didChangeConfiguration', {
      settings = client.config.settings
    })
  end
end

M.on_attach = function(client, bufnr)
  if vim.b.lsp_attached then return  end
  vim.b.lsp_attached = true

  -- keybindings are in lua/user/keymaps.lua
  doautocmd('User', {pattern = 'LSPKeybindings', group = 'user_cmds'})
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.make_config = function(config)
  local defaults = {
    root_dir = vim.fn.getcwd(),
    capabilities = M.capabilities,
    on_attach = M.on_attach,
    on_init = M.on_init,
    flags = {
      debounce_text_changes = 150,
    },
  }

  return vim.tbl_deep_extend(
    'force',
    defaults,
    config
  )
end

M.diagnostics = function()
  local sign = function(opts)
    vim.fn.sign_define(opts.name, {
      texthl = opts.name,
      text = opts.text,
      numhl = ''
    })
  end

  sign({name = 'DiagnosticSignError', text = '✘'})
  sign({name = 'DiagnosticSignWarn', text = '▲'})
  sign({name = 'DiagnosticSignHint', text = '⚑'})
  sign({name = 'DiagnosticSignInfo', text = ''})

  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  })

  autocmd('ModeChanged', {
    group = augroup,
    pattern = {'n:i', 'v:s'},
    desc = 'Disable diagnostics while typing',
    callback = function() vim.diagnostic.disable(0) end
  })

  autocmd('ModeChanged', {
    group = augroup,
    pattern = 'i:n',
    desc = 'Enable diagnostics when leaving insert mode',
    callback = function() vim.diagnostic.enable(0) end
  })
end

M.handlers = function()
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {border = 'rounded'}
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {border = 'rounded'}
  )
end

M.setup = function()
  M.handlers()
  M.diagnostics()
end

return M

