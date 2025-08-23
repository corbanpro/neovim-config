return {
  { 'nvim-lua/plenary.nvim', lazy = true },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    keys = {
      {
        '<leader>a',
        function()
          vim.print 'Pinned'
          require('harpoon'):list():add()
        end,
        desc = '[A]dd current file to Harpoon',
      },
      {
        '<C-e>',
        function()
          require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
        end,
        desc = 'Open Harpoon window',
      },
      {
        '<C-H>',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = 'Select Harpoon entry 1',
      },
      {
        '<C-J>',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = 'Select Harpoon entry 2',
      },
      {
        '<C-K>',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = 'Select Harpoon entry 3',
      },
      {
        '<C-L>',
        function()
          require('harpoon'):list():select(4)
        end,
        desc = 'Select Harpoon entry 4',
      },
    },
    config = function()
      require('harpoon'):setup {
        settings = {
          save_on_toggle = true,
          save_on_ui_close = true,
        },
      }
    end,
  },
}
