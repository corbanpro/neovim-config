-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- vim.opt.autowriteall = true
vim.opt.relativenumber = true
-- custom keymaps
vim.keymap.set('n', '<leader>ot', '<cmd>:tabnew<cr>', { desc = '[O]pen New [T]ab' })
vim.keymap.set('n', '<leader>rl', 'yyi:lua<space><C-r>"<cr>', { desc = '[R]un in [L]ua' })
vim.keymap.set('i', '{', '{}<left>', { desc = 'Add complimentary braces' })
vim.keymap.set('i', '(', '()<left>', { desc = 'Add complimentary parenthesis' })
vim.keymap.set('i', '[', '[]<left>', { desc = 'Add complimentary brackets' })
vim.keymap.set('i', '<C-z>', '<cmd>:undo<cr>', { desc = 'undo' })
vim.keymap.set('i', '<A-z>', '<cmd>:redo<cr>', { desc = 'redo' })
vim.keymap.set('i', '<C-R>', '<C-G>u<C-R>', { desc = 'augmented paste' })
vim.keymap.set({ 'i', 'n' }, '<A-k>', '<cmd>:m -2<CR>', { desc = 'Move line up' })
vim.keymap.set({ 'i', 'n' }, '<A-j>', '<cmd>:m +1<CR>', { desc = 'Move line down' })

return {

  'rust-lang/rust.vim',
  'ThePrimeagen/vim-be-good',
  'neovim/nvim-lspconfig',
  { 'nvim-tree/nvim-tree.lua', opts = { view = { width = 30 }, filters = { dotfiles = true } } },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'VeryLazy',
    config = function()
      local null_ls = require 'null-ls'
      local formatting = null_ls.builtins.formatting
      null_ls.setup { sources = { formatting.prettier.with { format_on_save = true } } }
    end,
  },
  -- 'MunifTanjim/prettier.nvim',
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
}
