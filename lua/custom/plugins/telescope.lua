local function show_history()
  local fn = require('telescope').extensions.git_file_history.git_file_history
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local ok, _ = pcall(fn)
  if not ok then
    local path = vim.fn.expand '%:p:h'
    vim.cmd 'tab split'
    vim.fn.chdir(path)
    ok, _ = pcall(fn)
    if not ok then
      vim.cmd 'tabclose'
      vim.notify("Sorry, that's not a git file. Awkward...", vim.log.levels.WARN)
      return
    end
  end

  if line > 15 then
    vim.api.nvim_create_autocmd('User', {
      pattern = 'TelescopePreviewerLoaded',
      callback = function()
        for _ = 1, line - 15 do
          vim.cmd [[execute "normal! 1\<C-d>"]]
        end

        vim.cmd 'normal! zz'
      end,
    })
  end
end

return {
  { 'nvim-lua/plenary.nvim', lazy = true }, -- Telescope, todo-comments, neo-tree, harpoon, nvim-html-css, LazyGit
  { 'nvim-telescope/telescope-ui-select.nvim', lazy = true },
  { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font, lazy = true },
  { 'tpope/vim-fugitive' },
  { 'isak102/telescope-git-file-history.nvim' },
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    config = function()
      local telescope = require 'telescope'
      local builtin = require 'telescope.builtin'

      telescope.setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
        defaults = {
          -- file_ignore_patterns = {
          --   '.*.min.js',
          --   '.*_templ.go',
          --   '.next/',
          --   'target/',
          --   'node_modules/',
          --   '.git/',
          --   '.cargo/',
          --   '.rustup/',
          --   '.nuxt/',
          --   'package.lock.json',
          --   'archive/',
          --   'docs/',
          --   'cdk.out/',
          --   'vendor/',
          --   -- 'dist/',
          --   'tsc.out/',
          --   'fake_*',
          -- },
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

      require('telescope').load_extension 'ui-select'
      require('telescope').load_extension 'git_file_history'

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      -- vim.keymap.set('n', '<leader>sf', function()
      --   builtin.find_files { hidden = true, no_ignore = true }
      -- end, { desc = '[S]earch [F]iles' })
      -- vim.keymap.set('n', '<leader>sb', builtin.builtin, { desc = '[S]earch Telescope [B]uiltin' })
      -- vim.keymap.set('n', '<leader>sg', function()
      --   builtin.grep_string {
      --     shorten_path = true,
      --     word_match = '-w',
      --     only_sort_text = true,
      --     search = '',
      --   }
      -- end, { desc = '[S]earch [G]rep' })

      -- vim.keymap.set('n', '<leader>se', function()
      --   builtin.live_grep { hidden = true, no_ignore = true }
      -- end, { desc = '[S]earch by Grep [E]xact' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      -- vim.keymap.set('n', '<leader>sq', builtin.quickfix, { desc = '[S]earch [Q]uickfix' })
      vim.keymap.set('n', '<leader>s-', builtin.quickfixhistory, { desc = '[S]earch [-] Quickfix History' })
      vim.keymap.set('n', '<leader>oh', show_history, { desc = '[O]pen File [H]istory' })

      -- vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      -- vim.keymap.set('n', '<leader>s.', function()
      --   builtin.oldfiles { hidden = true, no_ignore = true }
      -- end, { desc = '[S]earch Recent Files ("." for repeat)' })
      -- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      -- vim.keymap.set('n', '<leader>/', function()
      --   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      --     winblend = 10,
      --     previewer = true,
      --   })
      -- end, { desc = '[/] Fuzzily search in current buffer' })

      -- vim.keymap.set('n', '<leader>s/', function()
      --   builtin.live_grep {
      --     grep_open_files = true,
      --     prompt_title = 'Live Grep in Open Files',
      --   }
      -- end, { desc = '[S]earch [/] in Open Files' })

      -- vim.keymap.set('n', '<leader>sn', function()
      --   builtin.find_files { cwd = vim.fn.stdpath 'config' }
      -- end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
