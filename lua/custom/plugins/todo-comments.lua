vim.keymap.set('n', '<leader>st', '<cmd>:TodoTelescope keywords=TODO,FIX,HACK,BUG,WARNING,WARN<CR>', { desc = '[S]earch [T]odo' })

vim.keymap.set('n', ']t', function()
  require('todo-comments').jump_next()
end, { desc = 'Next todo comment' })

vim.keymap.set('n', '[t', function()
  require('todo-comments').jump_prev()
end, { desc = 'Previous todo comment' })

return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VimEnter',
  opts = {
    signs = true,
    highlight = {
      before = 'fg',
      keyword = 'wide',
      after = 'fg',
    },
  },
}
