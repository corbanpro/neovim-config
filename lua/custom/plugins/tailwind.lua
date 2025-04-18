return {
  'luckasRanarison/tailwind-tools.nvim',
  name = 'tailwind-tools',
  build = ':UpdateRemotePlugins',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim', -- optional
    'neovim/nvim-lspconfig', -- optional
  },
  ft = { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
  opts = {}, -- your configuration
}
