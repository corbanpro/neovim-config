return {
  'tpope/vim-sleuth', -- detect tabstop and shiftwidth automatically
  'theprimeagen/vim-be-good', -- tutorials and games
  'kkoomen/vim-doge', -- easy documentation
  'mbbill/undotree', -- undo tree
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      enable = true,
      multiline_threshold = 1,
    },
  },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
}
