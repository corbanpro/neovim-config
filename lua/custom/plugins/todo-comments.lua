return {
  { 'nvim-lua/plenary.nvim', lazy = true },
  {
    'folke/todo-comments.nvim',
    event = 'BufRead',
    opts = {
      signs = true,
    },
    keys = {
      { '<leader>st', '<cmd>:TodoTelescope keywords=TODO,FIX,HACK,BUG,WARNING,WARN<CR>', desc = '[S]earch [T]odo' },
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
