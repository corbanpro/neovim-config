vim.keymap.set('n', '<leader>tu', '<cmd>:UndotreeToggle<CR>:UndotreeFocus<CR>', { desc = '[T]oggle [U]ndotree' })

return {
  'mbbill/undotree',
  event = 'VeryLazy',
}
