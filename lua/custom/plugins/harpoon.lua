return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
      local harpoon = require 'harpoon'

      require('custom.remap').harpoon.set_keymaps(harpoon)
    end,
  },
}
