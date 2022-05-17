local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command
local escape = vim.fn.fnameescape
local fmt = string.format
local s = {}

local join = function(...) return table.concat({...}, '/') end
local session_dir = join(vim.fn.stdpath('data'),  'sessions')

local save_session = function()
  local session = vim.v.this_session
  if session == '' then return end

  vim.cmd(fmt('mksession! %s', escape(session)))
end

local load_session = function(input)
  save_session()

  local name = input.args
  local file = join(session_dir, name)

  if vim.fn.filereadable(file) == 1 then
    s.update_history(name)
  end

  vim.cmd(fmt('source %s.vim', escape(file)))
end

command('SessionNew', function(input)
  save_session()

  local name = input.args
  local file = escape(join(session_dir, name))
  local save_cmd = fmt('mksession %s.vim', file)
  local ok = pcall(vim.cmd, save_cmd)

  if not ok and vim.fn.filereadable(session_dir) == 0 then
    vim.fn.mkdir(session_dir, 'p')
    vim.cmd(save_cmd)

    local data = vim.json.encode({[vim.fn.getcwd()] = name})
    vim.fn.writefile({data}, join(session_dir, 'history.json'))
    return
  end

  s.update_history(name)
end, {nargs = 1})

command('SessionLoad', load_session, {nargs = 1})

command('SessionLoadCurrent', function(input)
  local file = join(session_dir, 'history.json')
  local content = vim.fn.readfile(file, '', 1)
  local data = vim.json.decode(content[1])
  local current = data[vim.fn.getcwd()]

  if current then
    load_session({args = current})
  end
end, {})

command('SessionSave', save_session, {})

command('SessionConfig', function()
  local session = vim.v.this_session
  if session == '' then return end

  local path = vim.fn.fnamemodify(session, ':r')
  vim.cmd(fmt('edit %sx.vim', vim.fn.fnameescape(path)))
end, {})

s.update_history = function(name)
  local file = join(session_dir, 'history.json')
  local content = vim.fn.readfile(file, '', 1)
  local data = vim.json.decode(content[1])

  data[vim.fn.getcwd()] = name

  vim.fn.writefile({vim.json.encode(data)}, file)
end

autocmd('VimLeavePre', {
  group = 'user_cmds',
  desc = 'Save active session on exit',
  callback = save_session
})

