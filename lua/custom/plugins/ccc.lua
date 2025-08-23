-- color picker
return {
  {
    'uga-rosa/ccc.nvim',
    event = 'BufRead',
    cmd = {
      'CccPick',
      'CccConvert',
      'CccHighlighterEnable',
      'CccHighlighterDisable',
      'CccHighlighterToggle',
    },
    opts = {
      highlighter = {
        auto_enable = true,
      },
    },
    keys = {
      {
        '<leader>oc',
        '<cmd>:CccPick<CR>',
        desc = '[O]pen [C]olor Picker',
      },
    },
  },
}
