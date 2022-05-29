local M = {}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local doautocmd = vim.api.nvim_exec_autocmds
local fmt = string.format

local server_group = 'LSP_server_%s'

M.make_config = function(config)
  local defaults = {
    root_dir = vim.fn.getcwd(),
    capabilities = M.capabilities,
    on_attach = M.on_attach,
    on_init = M.on_init,
    on_exit = M.on_exit,
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

M.on_init = function(client, results)
  if results.offsetEncoding then
    client.offset_encoding = results.offsetEncoding
  end

  if client.config.settings then
    client.notify('workspace/didChangeConfiguration', {
      settings = client.config.settings
    })
  end

  local group = augroup(fmt(server_group, client.id), {clear = true})
  local attach = function()
    require('lsp.client').buf_attach(client.config.filetypes, client.id)
  end

  autocmd('BufEnter', {
    pattern = '*',
    group = group,
    desc = fmt('Attach LSP: %s', client.name),
    callback = attach
  })

  if vim.v.vim_did_enter == 1 then
    attach()
  end
end

M.on_exit = vim.schedule_wrap(function(code, signal, client_id)
  local group = fmt(server_group, client_id)

  if vim.fn.exists(fmt('#%s', group)) == 1 then
    vim.api.nvim_del_augroup_by_name(group)
  end
end)

M.on_attach = function(client, bufnr)
  if vim.b.lsp_attached then return  end
  vim.b.lsp_attached = true
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
  vim.bo.tagfunc = 'v:lua.vim.lsp.tagfunc'

  -- keybindings are in lua/user/keymaps.lua
  doautocmd('User', {pattern = 'LSPKeybindings', group = 'user_cmds'})
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

return M

