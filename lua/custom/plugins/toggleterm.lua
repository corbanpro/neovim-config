return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    event = 'BufWinEnter',
    opts = {
      direction = 'float',
      on_open = function(terminal)
        require('custom.remap').toggleterm.set_keymaps(terminal)
      end,
    },
  },
}
