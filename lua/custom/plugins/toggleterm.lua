local shells = {}
local last_used = 0

local function open_default_shell(direction, default)
  return function()
    local shell_name = ''
    local index = 0

    if default then
      if #shells == 0 then
        index = 1
        table.insert(shells, 'default')
      else
        index = last_used
      end
      shell_name = shells[index] or 'default'
    else
      shell_name = vim.fn.input 'Terminal Name: '
      for k, v in pairs(shells) do
        if v == shell_name then
          index = k
        end
      end

      if index == 0 then
        table.insert(shells, shell_name)
        index = #shells
      end
    end

    last_used = index
    local command = index .. 'ToggleTerm direction=' .. direction .. ' name="' .. shell_name .. '"'
    vim.print(command)
    vim.cmd(command)
  end
end

vim.keymap.set('n', '<leader>tt', open_default_shell 'float', { desc = '[T]oggle [T]erminal - ToggleTerm' })
vim.keymap.set({ 'n', 'i' }, '<C-\\>', open_default_shell('float', true), { desc = 'Toggle Terminal - ToggleTerm' })
vim.keymap.set('n', '<C-s>', '<cmd>:TermSelect<CR>', { desc = 'Select Terminal' })

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    event = 'VeryLazy',
    opts = {
      direction = 'float',
      on_open = function(terminal)
        vim.api.nvim_buf_set_keymap(terminal.bufnr, 'n', '<C-\\>', '<cmd>close<CR>', { noremap = true, silent = true, desc = 'Close Shell - ToggleTerm' })
        vim.api.nvim_buf_set_keymap(terminal.bufnr, 'n', '<Esc>', '<cmd>close<CR>', { noremap = true, silent = true, desc = 'Close Shell - ToggleTerm' })
        vim.api.nvim_buf_set_keymap(terminal.bufnr, 't', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Exit terminal mode - ToggleTerm' })
        vim.api.nvim_buf_set_keymap(terminal.bufnr, 't', '<C-\\>', '<cmd>close<CR>', { noremap = true, silent = true, desc = 'Close Shell - ToggleTerm' })
      end,
    },
  },
}
