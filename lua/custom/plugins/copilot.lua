vim.keymap.set('n', '<leader>cd', '<cmd>:Copilot disable<cr>', { desc = '[C]opilot [D]isable' })
vim.keymap.set('n', '<leader>ce', '<cmd>:Copilot enable<cr>', { desc = '[C]opilot [E]nable' })
return {
  'github/copilot.vim',
}
