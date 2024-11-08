return {
  { 'nvim-lua/plenary.nvim', lazy = true },
  {
    'kdheepak/lazygit.nvim',
    keys = { { '<leader>og', '<cmd>LazyGit<cr>', desc = '[O]pen [G]it - LazyGit' } },
    config = function()
      require('telescope').load_extension 'lazygit'
    end,
  },
}
