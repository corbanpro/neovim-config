return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    cmd = {
      'ToggleTerm',
      'TermExec',
      'TermSelect',
    },
    keys = {
      {
        '<C-\\>',
        '<cmd>ToggleTerm direction=float<CR>',
        mode = { 'i', 'n' },
        desc = 'Toggle Terminal - ToggleTerm',
      },
      {
        '<leader>ot',
        '<cmd>ToggleTerm direction=horizontal<CR>',
        desc = '[O]pen [T]erminal - ToggleTerm',
      },
    },
    opts = {
      direction = 'float',
      on_open = function(terminal)
        vim.api.nvim_buf_set_keymap(terminal.bufnr, 't', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Exit terminal mode - ToggleTerm' })
        vim.api.nvim_buf_set_keymap(terminal.bufnr, 'n', '<C-\\>', '<cmd>close<CR>', { noremap = true, silent = true, desc = 'Close Shell - ToggleTerm' })
        vim.api.nvim_buf_set_keymap(terminal.bufnr, 't', '<C-\\>', '<cmd>close<CR>', { noremap = true, silent = true, desc = 'Close Shell - ToggleTerm' })
      end,
    },
  },
}
