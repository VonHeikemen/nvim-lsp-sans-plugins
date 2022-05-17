local autocmd = vim.api.nvim_create_autocmd

-- Leader
vim.g.mapleader = ' '
local bind = vim.keymap.set

-- Go to first character in line
bind('', '<Leader>h', '^')

-- Go to last character in line
bind('', '<Leader>l', 'g_')

-- Write file
bind('n', '<Leader>w', ':write<cr>')

-- Safe quit
bind('n', '<Leader>qq', ':quitall<cr>')

-- Force quit
bind('n', '<Leader>Q', ':quitall!<cr>')

-- Close buffer
bind('n', '<Leader>bc', '<cmd>bdelete<cr>')

-- Close window
bind('n', '<Leader>bq', '<cmd>q<cr>')

-- Move to last active buffer
bind('n', '<Leader>bl', '<cmd>buffer #<cr>')

-- Show diagnostic message
bind('n', 'gl', vim.diagnostic.open_float)

-- Go to previous diagnostic
bind('n', '[d', vim.diagnostic.goto_prev)

-- Go to next diagnostic
bind('n', ']d', vim.diagnostic.goto_next)

autocmd('User', {
  pattern = 'LSPKeybindings',
  group = 'user_cmds',
  desc = 'LSP actions',
  callback = function()
    local lsp = vim.lsp.buf
    local opts = {buffer = true}

    bind('n', 'K', lsp.hover, opts)
    bind('n', 'gd', lsp.definition, opts)
    bind('n', 'gD', lsp.declaration, opts)
    bind('n', 'gi', lsp.implementation, opts)
    bind('n', 'go', lsp.type_definition, opts)
    bind('n', 'gr', lsp.references, opts)
    bind('n', 'gs', lsp.signature_help, opts)
    bind('n', '<F2>', lsp.rename, opts)
    bind('n', '<F4>', lsp.code_action, opts)
    bind('x', '<F4>', lsp.range_code_action, opts)

    bind('i', '<M-i>', lsp.signature_help, opts)
  end
})

