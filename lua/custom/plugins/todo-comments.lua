local root_patterns = { 'package.json', '.git', '.clang-format', 'pyproject.toml', 'setup.py' }
local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])

return {
  { 'nvim-lua/plenary.nvim', lazy = true },
  {
    'folke/todo-comments.nvim',
    event = 'BufRead',
    opts = {
      signs = true,
      keywords = {
        LATER = { icon = '' },
        DONE = { icon = '', color = 'hint' },
      },
    },
    keys = {
      { '<leader>st', '<cmd>:TodoTelescope cwd=' .. (root_dir or vim.fn.getcwd()) .. ' keywords=TODO,BUG<CR>', desc = '[S]earch [T]odo' },
      { '<leader>sc', '<cmd>:TodoTelescope cwd=' .. (root_dir or vim.fn.getcwd()) .. '<CR>', desc = '[S]earch [C]omments' },
      { '<leader>sl', '<cmd>:TodoTelescope cwd=' .. (root_dir or vim.fn.getcwd()) .. ' keywords=LATER<CR>', desc = '[S]earch [L]ater' },
      {
        ']t',
        function()
          require('todo-comments').jump_next()
        end,
        desc = 'Next todo comment',
      },
      {
        '[t',
        function()
          require('todo-comments').jump_prev()
        end,
        desc = 'Previous todo comment',
      },
    },
  },
}
