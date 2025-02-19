vim.g.netrw_liststyle = 3
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.colorcolumn = '100'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 20
vim.opt.lazyredraw = true
vim.opt.tabstop = 4

vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.list = true
vim.opt.signcolumn = 'yes'
vim.g.have_nerd_font = true
vim.opt.showmode = false
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
