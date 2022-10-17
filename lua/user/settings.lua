-- Don't use temp files
vim.opt.swapfile = false
vim.opt.backup = false

-- Enable relative numbers
vim.opt.relativenumber = true

-- Don't wrap lines
vim.opt.wrap = false

-- Always display signcolumn (for diagnostic related stuff)
vim.opt.signcolumn = 'yes'

-- If available, use the pretty colors
vim.opt.termguicolors = true

-- Tab set to two spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Apply theme
vim.cmd('colorscheme darkling')

