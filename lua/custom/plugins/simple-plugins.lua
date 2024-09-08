return {
  'tpope/vim-sleuth', -- detect tabstop and shiftwidth automatically
  'theprimeagen/vim-be-good', -- tutorials and games
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      enable = true,
      multiline_threshold = 1,
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'mbbill/undotree',
    config = function()
      require('custom.remap').undotree.set_keymaps()
    end,
  },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
}
