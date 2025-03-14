return {
  {
    'petertriho/nvim-scrollbar',
    dependancies = {
      'folke/tokyonight.nvim',
    },
    config = function()
      local colors = require('tokyonight.colors').setup()
      require('scrollbar').setup {
        excluded_filetypes = {
          'neo-tree',
        },
        marks = {
          Cursor = {
            text = '#',
            color = colors.info,
          },
          Error = {
            text = { 'e', 'E' },
          },
          Warn = {
            text = { 'w', 'W' },
          },
          Hint = {
            text = { 'h', 'H' },
          },
        },
      }
    end,
  },
}
