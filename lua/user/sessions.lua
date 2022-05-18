local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command
local escape = vim.fn.fnameescape
local fmt = string.format
local s = {}

local session_path = './.nvim/Session.vim'

local save_session = function()
  local session = vim.v.this_session
  if session == '' then return end

  vim.cmd(fmt('mksession! %s', escape(session)))
end

local load_session = function(input)
  save_session()
  vim.cmd(fmt('source %s.vim', escape(session_path)))
end

command('SessionLoad', load_session, {nargs = 1})
command('SessionSave', save_session, {})

command('SessionNew', function(input)
  local session = vim.v.this_session
  if session ~= '' then return end

  if vim.fn.filereadable(session_path) == 0 then
    vim.fn.mkdir(vim.fn.fnamemodify(session_path, ':h'), 'p')
  end

  vim.cmd(fmt('mksession %s', escape(session_path)))
end, {nargs = 1})

command('SessionConfig', function()
  local session = vim.v.this_session
  if session == '' then return end

  local path = vim.fn.fnamemodify(session, ':r')
  vim.cmd(fmt('edit %sx.vim', vim.fn.fnameescape(path)))
end, {})

autocmd('VimLeavePre', {
  group = 'user_cmds',
  desc = 'Save active session on exit',
  callback = save_session
})

