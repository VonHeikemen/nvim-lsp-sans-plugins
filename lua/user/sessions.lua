local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command
local session_path = './.nvim/Session.vim'

local save_session = function()
  local session = vim.v.this_session
  if session == '' then
    return
  end

  vim.cmd.mksession({session, bang = true})
end

local load_session = function(input)
  save_session()
  vim.cmd.source(session_path)
end

command('SessionLoad', load_session, {})
command('SessionSave', save_session, {})

command('SessionNew', function(input)
  local session = vim.v.this_session
  if session ~= '' then
    return
  end

  if vim.fn.filereadable(session_path) == 0 then
    vim.fn.mkdir(vim.fn.fnamemodify(session_path, ':h'), 'p')
  end

  vim.cmd.mksession(session_path)
end, {})

command('SessionConfig', function()
  local session = vim.v.this_session
  if session == '' then
    return
  end

  local path = vim.fn.fnamemodify(session, ':r')
  vim.cmd.edit(path .. 'x.vim')
end, {})

autocmd('VimLeavePre', {
  group = 'user_cmds',
  desc = 'Save active session on exit',
  callback = save_session
})

