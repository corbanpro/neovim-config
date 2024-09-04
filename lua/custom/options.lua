vim.g['netrw_liststyle'] = 3

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('i', '<C-z>', '<cmd>:undo<cr>', { desc = 'undo' })
vim.keymap.set('i', '<A-z>', '<cmd>:redo<cr>', { desc = 'redo' })
vim.keymap.set('i', '<C-R>', '<C-G>u<C-R>', { desc = 'augmented paste' })
vim.keymap.set('n', '<C-q>', '<C-v>', { desc = 'enter visual block mode' })

vim.keymap.set('i', '<A-k>', '<Esc><cmd>:m .-2<CR>==gi', { desc = 'Move line up' })
vim.keymap.set('i', '<A-j>', '<Esc><cmd>:m .+1<CR>==gi', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', '<cmd>:m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('n', '<A-j>', '<cmd>:m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move lines up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move lines down' })

vim.keymap.set('n', '<leader>rl', '<cmd>:yank<cr>:lua <C-R>"<cr>', { desc = '[R]un in [L]ua' })
vim.keymap.set('n', '<leader>ot', '<cmd>:tabnew<cr>', { desc = '[O]pen New [T]ab' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', {})
vim.keymap.set('n', '<C-u>', '<C-u>zz', {})

vim.keymap.set('n', '<C-Space>', '$', {})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
