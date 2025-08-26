return {
  { 'rose-pine/neovim', priority = 1000, name = 'rose-pine' },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
}
