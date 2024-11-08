return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufRead',
    opts = {
      enable = true,
      multiline_threshold = 1,
    },
  },
}
