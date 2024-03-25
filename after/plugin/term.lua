local api = vim.api

-- Function to apply settings to the terminal buffer
local function set_term_settings()
  vim.wo.number = false
  vim.wo.relativenumber = false
end

local function small_terminal()
  vim.cmd 'new' -- Open a new window
  vim.cmd 'wincmd J' -- Move the window to the bottom
  vim.api.nvim_win_set_height(0, 12) -- Set the window height
  vim.wo.winfixheight = true -- Make the window height fixed
  vim.cmd 'term' -- Start a terminal in the new window
end

-- Autocommand that triggers the `set_term_settings` function on entering terminal mode
api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = set_term_settings,
})

vim.keymap.set('n', '<leader>t', ':vsplit | term<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>st', small_terminal, { desc = 'Open a small terminal at the bottom' })
