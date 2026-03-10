return {
  {
    'tpope/vim-dotenv',
    config = function()
      vim.cmd 'Dotenv ~/.config/nvim/.env'
    end,
  },
}
