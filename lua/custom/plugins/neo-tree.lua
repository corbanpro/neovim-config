-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  -- dependencies
  { 'MunifTanjim/nui.nvim', lazy = true },
  { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font, lazy = true },
  { 'nvim-lua/plenary.nvim', lazy = true }, -- Telescope, todo-comments, neo-tree, harpoon, nvim-html-css, LazyGit
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    keys = { { '\\', ':Neotree reveal position=left toggle=true<CR>', desc = 'Open NeoTree', silent = true } },
    event = 'VimEnter',
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
          visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },
}
