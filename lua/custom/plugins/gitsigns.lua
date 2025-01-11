return {
  {
    'lewis6991/gitsigns.nvim',
    dependancies = {
      'petertriho/nvim-scrollbar',
    },
    event = 'BufRead',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      }
      require('scrollbar.handlers.gitsigns').setup()
    end,
  },
}
