local autocmd = vim.api.nvim_create_autocmd

if vim.o.columns < 90 then
  -- If the screen is small, occupy half
  vim.g.netrw_winsize = 50
else
  -- else take 30%
  vim.g.netrw_winsize = 30
end

-- Hide banner
vim.g.netrw_banner = 0

-- Hide dotfiles
vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]

-- A better copy command
vim.g.netrw_localcopydircmd = 'cp -r'

-- Better keymaps for Netrw
local netrw_mapping = function()
  local bind = vim.keymap.set
  local opts = {buffer = true, remap = true}

  -- Close Netrw window
  bind('n', '<leader>dd', ':Lexplore<CR>', opts)
  bind('n', '<leader>da', ':Lexplore<CR>', opts)
  bind('n', 'q', ':Lexplore<CR>', opts)

  -- Go to file and close Netrw window
  bind('n', 'L', '<CR>:Lexplore<CR>', opts)

  -- Go back in history
  bind('n', 'H', 'u', opts)

  -- Go up a directory
  bind('n', 'h', '-^', opts)

  -- Go down a directory / open file
  bind('n', 'l', '<CR>', opts)

  -- Toggle dotfiles
  bind('n', 'za', 'gh', opts)

  -- Toggle the mark on a file
  bind('n', '<TAB>', 'mf', opts)

  -- Unmark all files in the buffer
  bind('n', '<S-TAB>', 'mF', opts)

  -- Unmark all files
  bind('n', '<Leader><TAB>', 'mu', opts)

  -- 'Bookmark' a directory
  bind('n', 'bb', 'mb', opts)

  -- Delete the most recent directory bookmark
  bind('n', 'bd', 'mB', opts)

  -- Got to a directory on the most recent bookmark
  bind('n', 'bl', 'gb', opts)

  -- Create a file
  bind('n', 'ff', '%', opts)

  -- Rename a file
  bind('n', 'fe', 'R', opts)

  -- Copy marked files
  bind('n', 'fc', 'mc', opts)

  -- Move marked files
  bind('n', 'fx', 'mm', opts)

  -- Execute a command on marked files
  bind('n', 'f;', 'mx', opts)

  -- Show the list of marked files
  bind('n', 'fl', ':echo join(netrw#Expose("netrwmarkfilelist"), "\n")<CR>', opts)

  -- Show the current target directory
  bind('n', 'fq', [[:echo 'Target:' . netrw#Expose("netrwmftgt")<CR>]], opts)

  -- Set the directory under the cursor as the current target
  bind('n', 'fg', 'mtfq', opts)

  -- Close the preview window
  bind('n', 'P', '<C-w>z', opts)
end

autocmd('filetype', {
  pattern = 'netrw',
  group = 'user_cmds',
  desc = 'Netrw keybindings',
  callback = netrw_mapping
})

