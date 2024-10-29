return {

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      -- {
      --   'nvim-telescope/telescope-live-grep-args.nvim',
      --   -- This will not install any breaking changes.
      --   -- For major updates, this must be adjusted manually.
      --   version = '^1.0.0',
      -- },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      local telescope = require 'telescope'
      telescope.setup {
        defaults = {
          file_ignore_patterns = { 'node_modules', '.git', '.cargo', '.rustup', '.nuxt', '%lock.json', 'archive' },

          mappings = {
            i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          oldfiles = {
            hidden = true,
          },
          live_grep = {
            hidden = true,
          },
          resume = {
            hidden = true,
          },
          buffers = {
            hidden = true,
          },
        },
        extensions = {
          -- live_grep_args = {},
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }
      -- telescope.load_extension 'live_grep_args'

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      require('custom.remap').telescope.set_keymaps(builtin)
    end,
  },
}
