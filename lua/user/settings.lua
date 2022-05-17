local set = vim.opt

-- Don't use temp files
set.swapfile = false
set.backup = false

-- Enable syntax highlight
vim.cmd('syntax enable')

-- Always display signcolumn (for diagnostic related stuff)
set.signcolumn = 'yes'

-- If available, use the pretty colors
set.termguicolors = true

-- Tab set to two spaces
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true

-- Apply theme
vim.cmd('colorscheme darkling')

-- Status line
set.statusline = '%=%r%m %l:%c %p%% %y '

