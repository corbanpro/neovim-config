return {
  {
    'uga-rosa/ccc.nvim',
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
        lsp = true,
      },
    },
  },
}
