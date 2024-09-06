return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'ThePrimeagen/vim-be-good', -- tutorials and games
  'nvim-treesitter/nvim-treesitter-context',
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle [U]ndotree' })
    end,
  },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {},
  },
}
