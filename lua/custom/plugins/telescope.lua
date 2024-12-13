return {
  { 'nvim-telescope/telescope-project.nvim', lazy = true },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    lazy = true,
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  { 'nvim-lua/plenary.nvim', lazy = true }, -- Telescope, todo-comments, neo-tree, harpoon, nvim-html-css, LazyGit
  { 'nvim-telescope/telescope-ui-select.nvim', lazy = true },
  { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font, lazy = true },
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    config = function()
      require('telescope').load_extension 'fzf'
      require('telescope').load_extension 'ui-select'
      require('telescope').load_extension 'project'

      local telescope = require 'telescope'
      local builtin = require 'telescope.builtin'

      telescope.setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
        defaults = {
          file_ignore_patterns = { 'target', 'node_modules/', '.git/', '.cargo/', '.rustup/', '.nuxt/', 'package.lock.json', 'archive/', 'docs/', 'dist/' },
          mappings = {
            i = { ['<C-Space>'] = 'to_fuzzy_refine' },
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
            path_display = { shorten = { len = 1, exclude = { -1, -2, -3 } } },
          },
          grep_string = {
            hidden = true,
            path_display = { shorten = { len = 1, exclude = { -1, -2, -3 } } },
          },
          resume = {
            hidden = true,
          },
          buffers = {
            hidden = true,
          },
          keymaps = {},
          help_tags = {},
          builtin = {},
          diagnostics = {},
          quickfix = {},
          quickfixhistory = {},
          current_buffer_fuzzy_find = {},
        },
      }

      vim.keymap.set('n', '<leader>sp', function()
        telescope.extensions.project.project { display_type = 'full' }
      end, { desc = '[S]earch [P]rojects' })

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', function()
        builtin.find_files { hidden = true, no_ignore = true }
      end, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sb', builtin.builtin, { desc = '[S]earch Telescope [B]uiltin' })
      vim.keymap.set('n', '<leader>sg', function()
        builtin.grep_string {
          shorten_path = true,
          word_match = '-w',
          only_sort_text = true,
          search = '',
        }
      end, { desc = '[S]earch [G]rep' })

      vim.keymap.set('n', '<leader>se', function()
        builtin.live_grep { hidden = true, no_ignore = true }
      end, { desc = '[S]earch by Grep [E]xact' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sq', builtin.quickfix, { desc = '[S]earch [Q]uickfix' })
      vim.keymap.set('n', '<leader>s-', builtin.quickfixhistory, { desc = '[S]earch [-] Quickfix History' })

      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', function()
        builtin.oldfiles { hidden = true, no_ignore = true }
      end, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = true,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
