return {
  { 'nvim-lua/plenary.nvim' },
  { 'tjdevries/express_line.nvim' },

  'mkitt/tabline.vim',
  'tpope/vim-sleuth',

  {
    'luukvbaal/statuscol.nvim',
    config = function()
      require('statuscol').setup {
        setopt = true,
      }
    end,
  },
}
