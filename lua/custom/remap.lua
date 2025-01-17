local HOVER_WIDTH = 75
-- helpers
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-q>', '<C-v>', { desc = 'enter visual block mode' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'scroll down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'scroll up' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'search terms stay centered' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'search terms stay centered' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["_dP]], { desc = '[P]aste over selection' })
vim.keymap.set({ 'n', 'v' }, '<C-Space>', '$', { desc = 'Move to end of line' })
vim.keymap.set({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = "navigate wrapped lines except you're not a psycho", expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = "navigate wrapped lines except you're not a psycho", expr = true, silent = true })
vim.keymap.set('n', '<leader>el', '"nyy:lua <C-R>"<cr>', { desc = '[E]xecute in [L]ua' })
vim.keymap.set('n', 'J', 'mzJ`z', { desc = "join lines, don't move cursor" })

-- smart quit
local function close_everything()
  vim.cmd 'Neotree close'
  vim.cmd 'cclose'
  vim.cmd 'Trouble diagnostics close'
  vim.cmd 'UndotreeHide'
end

vim.keymap.set('n', '<leader>q', function()
  close_everything()
  vim.cmd 'wa'
  vim.cmd 'qa'
end, { desc = 'Smart [Q]uit' })

vim.api.nvim_create_autocmd('VimLeavePre', {
  pattern = '*',
  callback = function()
    local path = '~/.local/share/nvim/sessions' .. vim.fn.getcwd()
    close_everything()
    vim.cmd('!mkdir -p ' .. path)
    vim.cmd('mksession! ' .. path .. '/Session.vim')
  end,
})

-- delete
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = '[D]elete without yanking' })
vim.keymap.set({ 'n', 'v' }, '<leader>D', [["_D]], { desc = '[D]elete without yanking' })
vim.keymap.set({ 'n', 'v' }, '<leader>x', [["_x]], { desc = '[X] Delete without yanking' })
vim.keymap.set({ 'n', 'v' }, '<leader>X', [["_X]], { desc = '[X] Delete without yanking' })
vim.keymap.set({ 'n', 'v' }, '<leader>c', [["_c]], { desc = '[C]hange without yanking' })
vim.keymap.set({ 'n', 'v' }, '<leader>C', [["_C]], { desc = '[C]hange without yanking' })

-- replace
local replace = require 'custom.replace'
vim.keymap.set('n', '<leader>ra', replace.n_replace_all, { desc = '[R]eplace Word - [A]ll' })
vim.keymap.set('v', '<leader>ra', replace.v_replace_all, { desc = '[R]eplace Selection - [A]ll' })
vim.keymap.set('n', '<leader>rc', replace.n_replace_confirm_all, { desc = '[R]eplace Word - [C]onfirm' })
vim.keymap.set('v', '<leader>rc', replace.v_replace_confirm_all, { desc = '[R]eplace Selection - [C]onfirm' })
vim.keymap.set('n', '<leader>ri', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]eplace [I]nline' })
vim.keymap.set('v', '<leader>ri', [["ny:%s/\<<C-r>6\>/<C-r>6/gI<Left><Left><Left>]], { desc = '[R]eplace [I]nline' })

-- move lines
vim.keymap.set('i', '<A-j>', '<Esc><cmd>:m .+1<CR>==gi', { desc = 'Move line down' })
vim.keymap.set('i', '<A-k>', '<Esc><cmd>:m .-2<CR>==gi', { desc = 'Move line up' })
vim.keymap.set('n', '<A-j>', '<cmd>:m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', '<cmd>:m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move lines up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move lines down' })

-- file
vim.keymap.set('n', '<leader>on', '<cmd>:enew<cr>', { desc = '[O]pen [N]ew file' })

-- quickfix
local function quickfix_toggle()
  local open = false
  for _, buffer in pairs(vim.fn.getwininfo()) do
    if buffer.quickfix == 1 then
      open = true
      break
    end
  end

  if open then
    vim.cmd 'cclose'
  else
    vim.cmd 'copen 15'
  end
end
vim.keymap.set('n', '<leader>tq', quickfix_toggle, { desc = '[T]oggle [Q]uickfix' })
vim.keymap.set('n', ']c', '<cmd>:cnext<CR>', { desc = 'Next quickfix' })
vim.keymap.set('n', ']C', '<cmd>:clast<CR>', { desc = 'Last quickfix' })
vim.keymap.set('n', '[c', '<cmd>:cprevious<CR>', { desc = 'Previous quickfix' })
vim.keymap.set('n', '[C', '<cmd>:cfirst<CR>', { desc = 'First quickfix' })
vim.keymap.set('n', '[q', '<cmd>:colder<CR>', { desc = 'Previous quickfix list' })
vim.keymap.set('n', ']q', '<cmd>:cnewer<CR>', { desc = 'Next quickfix list' })

-- info hover
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
  width = HOVER_WIDTH,
})
vim.keymap.set('n', 'K', function()
  vim.lsp.buf.hover()
  local hover_buffer = -1
  for _, buffer in pairs(vim.fn.getwininfo()) do
    if buffer.variables['textDocument/hover'] ~= nil then
      hover_buffer = buffer.bufnr
      break
    end
  end
  if hover_buffer ~= -1 then
    vim.api.nvim_buf_set_keymap(hover_buffer, 'n', '<Esc>', '<cmd>:q<CR>', { noremap = true, silent = true })
  end
end, { desc = 'Show hover' })

-- diagnostic float
vim.keymap.set('n', ']d', function()
  vim.diagnostic.goto_next { float = false }
end, { desc = 'jump to next diagnostic' })
vim.keymap.set('n', '[d', function()
  vim.diagnostic.goto_prev { float = false }
end, { desc = 'jump to previos diagnostic' })
vim.keymap.set('n', 'L', function()
  local open = false
  for _, buffer in pairs(vim.fn.getwininfo()) do
    if buffer.variables.diagnostic_float ~= nil then
      open = true
      break
    end
  end
  if open then
    vim.diagnostic.open_float { scope = 'line', focus = true, border = 'rounded', width = HOVER_WIDTH, focus_id = 'diagnostic_float' }
    local hover_buffer = -1
    for _, buffer in pairs(vim.fn.getwininfo()) do
      if buffer.variables.diagnostic_float ~= nil then
        hover_buffer = buffer.bufnr
        break
      end
    end
    if hover_buffer ~= -1 then
      vim.api.nvim_buf_set_keymap(hover_buffer, 'n', '<Esc>', '<cmd>:q<CR>', { noremap = true, silent = true })
    end
  else
    vim.diagnostic.open_float { scope = 'line', focus = false, border = 'rounded', width = HOVER_WIDTH, focus_id = 'diagnostic_float' }
  end
end, { desc = 'show diagnostic under cursor' })

-- toggle diagnostic hints
vim.g.showing_diagnostic_hints = true
vim.keymap.set('n', '<leader>td', function()
  if vim.g.showing_diagnostic_hints then
    vim.g.showing_diagnostic_hints = false
    vim.print 'Disabling diagnostic hints'
    vim.diagnostic.config {
      virtual_text = false,
    }
  else
    vim.g.showing_diagnostic_hints = true
    vim.print 'Enabling diagnostic hints'
    vim.diagnostic.config {
      virtual_text = true,
    }
  end
end, { desc = '[T]oggle [D]iagnostic hints' })

--Stop
vim.keymap.set('n', '<c-z>', function()
  vim.print "Don't do that"
end, { desc = 'Stop' })
vim.keymap.set('n', 'Q', function()
  vim.print "Don't do that"
end, { desc = 'Stop' })

-- Run File
--[[
-- i am writing a bunch of stuff, and it's pretty cool
--
--]]

local function run_file()
  local function run_in_toggleterm(command)
    local Terminal = require('toggleterm.terminal').Terminal
    local cmd = "echo '" .. command .. "'; echo; " .. command .. '; bash'
    vim.print(cmd)
    local term = Terminal:new { cmd = cmd, display_name = 'Run File', direction = 'float' }
    term:toggle()
  end

  local buf_num = vim.api.nvim_get_current_buf()
  local file_type = vim.bo[buf_num].filetype
  local file_path = vim.api.nvim_buf_get_name(buf_num)
  local supported_filetypes = {
    javascript = function()
      run_in_toggleterm('node ' .. file_path)
    end,
    lua = function()
      run_in_toggleterm('nvim --headless -c "source ' .. file_path .. '" -c "qa"')
    end,
    rust = function()
      run_in_toggleterm('cd ' .. vim.fn.expand '%:p:h' .. ' && (cargo run || cargo script ' .. file_path .. ' ) && cd - > /dev/null')
    end,
  }

  if supported_filetypes[file_type] == nil then
    vim.print('Unsupported File Type: ' .. file_type)
    return
  end

  supported_filetypes[file_type]()
end

vim.keymap.set('n', '<leader>er', run_file, { desc = '[E]xecute [R]un' })
