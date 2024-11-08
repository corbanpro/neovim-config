return {
  -- dependencies
  {
    'nvimtools/hydra.nvim',
    lazy = true,
  },
  {
    'smoka7/multicursors.nvim',
    opts = {},
    cmd = {
      'MCstart',
      'MCvisual',
      'MCclear',
      'MCpattern',
      'MCvisualPattern',
      'MCunderCursor',
    },
    keys = {
      {
        mode = 'n',
        '<leader>m',
        '<cmd>:MCunderCursor<cr>',
        desc = '[M]ulticursor',
      },
      {
        mode = 'v',
        '<leader>m',
        '<cmd>:MCstart<cr>',
        desc = '[M]ulticursor',
      },
    },
  },
}
