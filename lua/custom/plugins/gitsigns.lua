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
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text_pos = 'right_align',
          virt_text_priority = 5000,
          delay = 500,
        },
      }
      require('scrollbar.handlers.gitsigns').setup()
    end,
  },
}
