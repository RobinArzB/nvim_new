vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('text-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = vim.api.nvim_create_augroup('edit_text', { clear = true }),
  pattern = { 'gitcommit', 'markdown', 'txt' },
  desc = 'Enable spell checking and text wrapping for certain filetypes',
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
