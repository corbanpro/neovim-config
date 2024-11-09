-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  -- dependencies
  { 'MunifTanjim/nui.nvim', lazy = true },
  { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font, lazy = true },
  { 'nvim-lua/plenary.nvim', lazy = true },
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    keys = { { '\\', ':Neotree reveal position=left toggle=true<CR>', desc = 'Open NeoTree', silent = true } },
    cmd = { 'Neotree' },
    opts = {
      enable_git_status = false,
      close_if_last_window = true,
      default_component_configs = {
        name = {
          trailing_slash = true,
        },
      },
      filesystem = {
        filtered_items = {
          hide_by_name = {
            '.session.vim',
          },
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },
}
