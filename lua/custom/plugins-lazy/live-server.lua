vim.g.live_server_active = false
local function live_server_toggle()
  if vim.g.live_server_active then
    vim.cmd 'LiveServerStop'
    vim.g.live_server_active = false
  else
    vim.cmd 'LiveServerStart'
    vim.g.live_server_active = true
  end
end

return {
  {
    'barrett-ruth/live-server.nvim',
    build = 'npm add -g live-server',
    cmd = { 'LiveServerStart', 'LiveServerStop' },
    keys = {
      { '<leader>ts', live_server_toggle, desc = '[T]oggle Live [S]erver' },
    },
    config = true,
  },
}
