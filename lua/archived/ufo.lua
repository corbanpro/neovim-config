return {
  {
    'kevinhwang91/promise-async',
  },
  {
    'kevinhwang91/nvim-ufo',
    config = function()
      local ufo = require 'ufo'

      vim.keymap.set('n', 'zR', ufo.openAllFolds)
      vim.keymap.set('n', 'zM', ufo.closeAllFolds)

      ufo.setup {
        provider_selector = function()
          return { 'treesitter', 'indent' }
        end,
      }
    end,
  },
}
