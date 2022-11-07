local M = {}
local s = {}
local exec = vim.api.nvim_command

s.current = {
  buffer = nil,
  opened = false,
}

s.config = {
  direction = 'bottom',
  size = 0.25
}

function M.setup(opts)
  local augroup = vim.api.nvim_create_augroup('term_cmds', {clear = true})
  local autocmd = vim.api.nvim_create_autocmd
  local command = vim.api.nvim_create_user_command

  M.settings(opts)

  command('ToggleTerminal', function() M.toggle() end, {})

  autocmd('BufEnter', {
    group = augroup,
    pattern = 'term://*',
    command = 'startinsert'
  })
  autocmd('TermOpen', {
    group = augroup,
    callback = function()
      vim.opt_local.swapfile = false
      vim.opt_local.buflisted = false
      vim.opt_local.modified = false
      vim.opt_local.relativenumber = false
      vim.opt_local.number = false
      exec('startinsert')
    end
  })
  autocmd('TermClose', {
    group = augroup,
    nested = true,
    callback = function()
      if vim.v.event.status == 0
        and vim.api.nvim_buf_is_valid(s.current.buffer)
      then
        pcall(vim.api.nvim_win_close, vim.fn.bufwinid(s.current.buffer), true)
        pcall(vim.api.nvim_buf_delete, s.current.buffer, {force = true})
      end

      s.current.buffer = nil
      s.current.opened = false
    end
  })
end

function M.settings(opts)
  if type(opts) == 'table' then
    s.config = vim.tbl_deep_extend('force', s.config, opts)
  end
end

function M.toggle(opts)
  opts = opts or {}
  if s.current.buffer == nil then
    s.create_terminal(opts)
  elseif s.current.opened then
    M.hide_terminal()
  else
    M.show_terminal(opts)
  end
end

function s.create_terminal(opts)
  opts = opts or {}
  local direction = opts.direction or s.config.direction
  local size = opts.size or s.config.size

  s.make_split({direction = direction, size = size})
  exec('terminal')
  vim.defer_fn(function()
    s.current.buffer = vim.fn.bufnr('%')
    s.current.opened = true
  end, 2)
end

function M.show_terminal(opts)
  opts = opts or {}
  if type(s.current.buffer) ~= 'number' then
    return
  end

  local direction = opts.direction or s.config.direction
  local size = opts.size or s.config.size

  s.make_split({direction = direction, size = size})
  vim.api.nvim_win_set_buf(0, s.current.buffer)
  s.current.opened = true
end

function M.hide_terminal()
  local win_term = vim.fn.bufwinid(s.current.buffer)
  if win_term == -1 then
    return
  end

  pcall(vim.api.nvim_win_close, win_term, 0)
  s.current.opened = false
end

function s.make_split(opts)
  opts = opts or {}
  local size = opts.size or 0.25

  local cmd = {
    range = {},
    cmd = 'split',
    mods = {
      silent = true,
      keepalt = true,
      vertical = false,
    }
  }

  if opts.direction == 'bottom' then
    cmd.mods.vertical = false
    cmd.mods.split = 'botright'
  elseif opts.direction == 'right' then
    cmd.mods.vertical = true
    cmd.mods.split = 'botright'
  elseif opts.direction == 'top' then
    cmd.mods.vertical = false
    cmd.mods.split = 'topleft'
  elseif opts.direction == 'left' then
    cmd.mods.vertical = true
    cmd.mods.split = 'topleft'
  end

  if cmd.mods.vertical then
    cmd.range[1] = vim.fn.float2nr(size * math.floor(vim.o.columns - 2))
  else
    cmd.range[1] = vim.fn.float2nr(size * math.floor(vim.o.lines - 2))
  end

  vim.cmd(cmd)
end

return M

