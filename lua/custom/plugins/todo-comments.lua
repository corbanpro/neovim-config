local root_patterns = { '.git', '.clang-format', 'pyproject.toml', 'setup.py' }
local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])

return {
  { 'nvim-lua/plenary.nvim', lazy = true },
  {
    'folke/todo-comments.nvim',
    event = 'BufRead',
    opts = {
      signs = true,
    },
    keys = {
      { '<leader>st', '<cmd>:TodoTelescope cwd=' .. (root_dir or vim.fn.getcwd()) .. ' keywords=TODO,FIX,HACK,BUG,WARNING,WARN<CR>', desc = '[S]earch [T]odo' },
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
