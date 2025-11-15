vim.api.nvim_create_user_command('DelJump', function(opts)
  local jumps = vim.fn.getjumplist()[1]
  local target = tonumber(opts.args)
  if not target then
    target = 1
  end
  if target < 1 or target > #jumps then
    vim.notify('Invalid jump index', vim.log.levels.ERROR)
    return
  end

  target = #jumps - target + 1

  -- Remove the chosen jump
  table.remove(jumps, target)

  -- Clear all jumps
  vim.cmd 'clearjumps'

  local initial_buf = vim.api.nvim_get_current_buf()

  -- Rebuild jumplist by going through entries
  for _, j in ipairs(jumps) do
    local bufnr, lnum, col = j.bufnr, j.lnum, j.col
    if vim.api.nvim_buf_is_loaded(bufnr) then
      vim.api.nvim_set_current_buf(bufnr)
      -- recreate jump without polluting real jumplist
      vim.cmd('keepjumps normal! ' .. lnum .. 'G' .. (col + 1) .. '|')
    end
  end

  vim.api.nvim_set_current_buf(initial_buf)
end, {})
