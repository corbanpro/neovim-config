return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup {
        settings = {
          save_on_toggle = true,
          save_on_ui_close = true,
        },
      }

      vim.keymap.set('n', '<leader>a', function()
        vim.print 'Pinned'
        harpoon:list():add()
      end, { desc = '[A]dd current file to Harpoon' })

      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Open Harpoon window' })

      vim.keymap.set('n', '<C-H>', function()
        harpoon:list():select(1)
      end, { desc = 'Select Harpoon entry 1' })
      vim.keymap.set('n', '<C-J>', function()
        harpoon:list():select(2)
      end, { desc = 'Select Harpoon entry 2' })
      vim.keymap.set('n', '<C-K>', function()
        harpoon:list():select(3)
      end, { desc = 'Select Harpoon entry 3' })
      vim.keymap.set('n', '<C-L>', function()
        harpoon:list():select(4)
      end, { desc = 'Select Harpoon entry 4' })
    end,
  },
}
