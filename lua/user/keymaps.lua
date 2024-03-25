local map = vim.keymap.set

-- Quality of life
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")
map('n', 'J', 'mzJ`z')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

map('x', '<leader>p', [["_dP]])
map({ 'n', 'v' }, '<leader>y', [["+y]])
map('n', '<leader>Y', [["+Y]])
map({ 'n', 'v' }, '<leader>P', [["+p]])
map({ 'n', 'v' }, '<leader>d', [["_d]])

map('n', 'Q', '<nop>')

map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

map('n', '<leader><leader>', function()
  vim.cmd 'so'
end)

map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<leader><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Decrease window width by 1
map('n', '<C-,>', '<C-W><', { noremap = true, silent = true })

-- Increase window width by 1
map('n', '<C-;>', '<C-W>>', { noremap = true, silent = true })

-- Toggle cody chat
map('n', '<leader>cc', function()
  require('sg.cody.commands').toggle()
end)

map('n', '<leader>cn', function()
  local name = vim.fn.input 'chat name: '
  require('sg.cody.commands').chat(name)
end)
map('v', '<leader>a', ':CodyContext<CR>')
map('v', '<leader>ce', ':CodyExplain<CR>')

map('n', '<leader>ss', function()
  require('sg.extensions.telescope').fuzzy_search_results()
end)

-- Helper function to set lazyredraw and restore its original state
local function set_lazyredraw_and_restore(cmd)
  local original_lazyredraw = vim.o.lazyredraw
  vim.o.lazyredraw = true
  vim.api.nvim_exec(cmd, false)
  vim.o.lazyredraw = original_lazyredraw
end

-- Mapping for gj
map('n', 'gj', function()
  local virtcol = vim.fn.virtcol '.'
  local cmd = '/\\%' .. virtcol .. 'v\\S<CR>:nohl<CR>'
  set_lazyredraw_and_restore(cmd)
end, { silent = true })

-- Mapping for gk
map('n', 'gk', function()
  local virtcol = vim.fn.virtcol '.'
  local cmd = '?\\%' .. virtcol .. 'v\\S<CR>:nohl<CR>'
  set_lazyredraw_and_restore(cmd)
end, { silent = true })

-- run the last command
map('n', '<leader><leader>c', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':<Up>', true, true, true), 'n', true)
end, { silent = true })

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
