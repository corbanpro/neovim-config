-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = require('custom.remap').neo_tree,
  opts = {
    enable_git_status = false,
    close_if_last_window = true,
    default_component_configs = {
      icon = {
        folder_closed = '*',
        folder_open = '*',
        folder_empty = '*',
      },
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
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['<C-\\>'] = 'close_window',
        },
      },
    },
  },
}
