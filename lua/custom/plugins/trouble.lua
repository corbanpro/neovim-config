return {
  {
    'folke/trouble.nvim',
    opts = {
      auto_close = true,
      warn_no_results = false,
      focus = true,
    },
    cmd = { 'Trouble' },
    keys = {
      {
        '<leader>tx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = '[T]oggle [X] Trouble Diagnostics',
      },
      {
        '<leader>tX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = '[T]oggle [X] Trouble Diagnostics (current buffer)',
      },
    },
  },
}
