vim.keymap.set('n', '<leader>st', '<cmd>:TodoTelescope keywords=TODO,FIX,HACK,BUG,WARNING,WARN<CR>', { desc = '[S]earch [T]odo' })

vim.keymap.set('n', ']t', function()
  require('todo-comments').jump_next()
end, { desc = 'Next todo comment' })

vim.keymap.set('n', '[t', function()
  require('todo-comments').jump_prev()
end, { desc = 'Previous todo comment' })

return {
  { 'nvim-lua/plenary.nvim', lazy = true },
  {
    'folke/todo-comments.nvim',
    event = 'BufRead',
    opts = {
      signs = true,
    },
  },
}
