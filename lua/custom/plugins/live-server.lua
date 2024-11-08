vim.g.live_server_active = false
vim.keymap.set('n', '<leader>es', function()
  if vim.g.live_server_active then
    vim.cmd 'LiveServerStop'
    vim.g.live_server_active = false
  else
    vim.cmd 'LiveServerStart'
    vim.g.live_server_active = true
  end
end, { desc = '[E]xecute Live [S]erver' })

return {
  'barrett-ruth/live-server.nvim',
  build = 'npm add -g live-server',
  cmd = { 'LiveServerStart', 'LiveServerStop' },
  config = true,
}
