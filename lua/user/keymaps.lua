local autocmd = vim.api.nvim_create_autocmd

-- Leader
vim.g.mapleader = ' '
local bind = vim.keymap.set

-- Go to first character in line
bind('', '<Leader>h', '^')

-- Go to last character in line
bind('', '<Leader>l', 'g_')

-- Whatever you delete, make it go away
bind({'n', 'x'}, 'x', '"_x')

-- Copy to clipboard
bind({'n', 'x'}, 'cp', '"+y')

-- Paste from clipboard
bind({'n', 'x'}, 'cv', '"+p')

-- Select all text
bind('n', '<leader>a', '<cmd>keepjumps normal! ggVG<cr>')

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

-- Use terminal
bind({'', 't', 'i'}, '<M-Space>', function()
  local direction = 'bottom'
  if vim.o.lines < 19 then
    direction = 'right'
  end

  require('user.terminal').toggle({direction = direction})
end)

autocmd('User', {
  pattern = 'LspAttached',
  group = 'user_cmds',
  desc = 'LSP actions',
  callback = function()
    local lsp = vim.lsp.buf
    local opts = {buffer = true}

    -- Display information about symbol under the cursor
    bind('n', 'K', lsp.hover, opts)

    -- Jump to definition
    bind('n', 'gd', lsp.definition, opts)

    -- Jump to declaration
    bind('n', 'gD', lsp.declaration, opts)

    -- List implementations
    bind('n', 'gi', lsp.implementation, opts)

    -- Jump to type definition
    bind('n', 'go', lsp.type_definition, opts)

    -- List references
    bind('n', 'gr', lsp.references, opts)

    -- Display function signature information
    bind('n', 'gs', lsp.signature_help, opts)
    bind('i', '<M-i>', lsp.signature_help, opts)

    -- Rename symbol
    bind('n', '<F2>', lsp.rename, opts)

    -- List code actions available at the current cursor position
    bind('n', '<F4>', lsp.code_action, opts)
    bind('x', '<F4>', lsp.range_code_action, opts)
  end
})

