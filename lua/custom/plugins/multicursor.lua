return {
  'smoka7/multicursors.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvimtools/hydra.nvim',
  },
  opts = {},
  cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
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
}
