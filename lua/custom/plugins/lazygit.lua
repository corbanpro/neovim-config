return {
  'kdheepak/lazygit.nvim',
  lazy = true,
  cmd = {
    'LazyGit',
  },
  -- optional for floating window border decoration
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = { { '<leader>og', '<cmd>LazyGit<cr>', desc = '[O]pen [G]it - LazyGit' } },

  config = function()
    require('telescope').load_extension 'lazygit'
  end,
}
