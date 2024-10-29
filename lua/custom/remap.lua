local exports = {}

-- helpers
vim.keymap.set('i', '<C-R>', '<C-G>u<C-R>', { desc = 'augmented paste' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-q>', '<C-v>', { desc = 'enter visual block mode' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'scroll down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'scroll up' })
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = '[P]aste over selection' })
vim.keymap.set({ 'n', 'v' }, '<C-Space>', '$', { desc = 'Move to end of line' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = '[D]elete without yanking' })
vim.keymap.set({ 'n', 'v' }, '<leader>x', [["_x]], { desc = '[X] Delete without yanking' })
vim.keymap.set({ 'n', 'v' }, '<leader>c', [["_c]], { desc = '[C]hange without yanking' })
vim.keymap.set({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = "navigate wrapped lines except you're not a psycho", expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = "navigate wrapped lines except you're not a psycho", expr = true, silent = true })
vim.keymap.set('n', '<leader>el', '"6yy:lua <C-R>"<cr>', { desc = '[E]xecute in [L]ua' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'search terms stay centered' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'search terms stay centered' })
vim.keymap.set('n', 'J', 'mzJ`z', { desc = "join lines, don't move cursor" })
vim.keymap.set('n', '<leader>ri', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]eplace [I]nline' })
vim.keymap.set('v', '<leader>ri', [["6y:%s/\<<C-r>6\>/<C-r>6/gI<Left><Left><Left>]], { desc = '[R]eplace [I]nline' })
vim.keymap.set('n', '<c-z>', function()
  vim.print "Don't do that"
end, { desc = 'Stop' })
vim.keymap.set('n', 'Q', function()
  vim.print "Don't do that"
end, { desc = 'Stop' })

-- quickfix
local quickfix_open = false
local function quickfix_toggle()
  if quickfix_open then
    vim.cmd 'cclose'
    quickfix_open = false
  else
    vim.cmd 'copen'
    quickfix_open = true
  end
end
vim.keymap.set('n', '<leader>tq', quickfix_toggle, { desc = '[T]oggle [Q]uickfix' })
vim.keymap.set('n', ']c', '<cmd>:cnext<CR>', { desc = 'Next quickfix' })
vim.keymap.set('n', ']C', '<cmd>:clast<CR>', { desc = 'Last quickfix' })
vim.keymap.set('n', '[c', '<cmd>:cprevious<CR>', { desc = 'Previous quickfix' })
vim.keymap.set('n', '[C', '<cmd>:cfirst<CR>', { desc = 'First quickfix' })
vim.keymap.set('n', '[q', '<cmd>:colder<CR>', { desc = 'Previous quickfix list' })
vim.keymap.set('n', ']q', '<cmd>:cnewer<CR>', { desc = 'Next quickfix list' })

-- replace
local replace = require 'custom.replace'
vim.keymap.set('n', '<leader>ra', replace.n_replace_all, { desc = '[R]eplace Word - [A]ll' })
vim.keymap.set('v', '<leader>ra', replace.v_replace_all, { desc = '[R]eplace Selection - [A]ll' })
vim.keymap.set('n', '<leader>rc', replace.n_replace_confirm_all, { desc = '[R]eplace Word - [C]onfirm' })
vim.keymap.set('v', '<leader>rc', replace.v_replace_confirm_all, { desc = '[R]eplace Selection - [C]onfirm' })

-- move lines
vim.keymap.set('i', '<A-j>', '<Esc><cmd>:m .+1<CR>==gi', { desc = 'Move line down' })
vim.keymap.set('i', '<A-k>', '<Esc><cmd>:m .-2<CR>==gi', { desc = 'Move line up' })
vim.keymap.set('n', '<A-j>', '<cmd>:m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', '<cmd>:m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move lines up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move lines down' })

-- file
vim.keymap.set('n', '<leader>on', '<cmd>:enew<cr>', { desc = '[O]pen [N]ew file' })

-- Tab
vim.keymap.set('n', '<leader>ot', '<cmd>:tabnew<cr>', { desc = '[O]pen [T]ab' })
vim.keymap.set('n', '<leader>ovt', '<C-W>v<cmd>:enew<cr>', { desc = '[O]pen [V]ertical [T]ab' })
vim.keymap.set('n', '<leader>oht', '<C-W>s<cmd>:enew<cr>', { desc = '[O]pen [H]orizontal [T]ab' })
vim.keymap.set('n', ']t', 'gt', { desc = 'Next tab' })
vim.keymap.set('n', '[t', 'gT', { desc = 'Previous tab' })

-- todo-comments
vim.keymap.set('n', '<leader>st', '<cmd>:TodoTelescope<CR>', { desc = '[S]earch [T]odo' })

-- ToggleTerm
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

vim.keymap.set('n', '<leader>ts', open_default_shell 'float', { desc = '[T]oggle [S]hell - ToggleTerm' })
vim.keymap.set({ 'n', 'i' }, '<C-\\>', open_default_shell('float', true), { desc = '[T]oggle [S]hell - ToggleTerm' })
vim.keymap.set('n', '<leader>tfs', open_default_shell 'float', { desc = '[T]oggle [F]loat [S]hell - ToggleTerm' })
vim.keymap.set('n', '<leader>tvs', open_default_shell 'vertical', { desc = '[T]oggle [V]ertical [S]hell - ToggleTerm' })
vim.keymap.set('n', '<leader>ths', open_default_shell 'horizontal', { desc = '[T]oggle [H]orizontal [S]hell - ToggleTerm' })
vim.keymap.set('n', '<leader>tts', open_default_shell 'tab', { desc = '[T]oggle [T]ab [S]hell - ToggleTerm' })
vim.keymap.set('n', '<C-s>', '<cmd>:TermSelect<CR>', { desc = 'Select Terminal' })

exports.toggleterm = {
  set_keymaps = function(terminal)
    vim.api.nvim_buf_set_keymap(terminal.bufnr, 'n', '<C-\\>', '<cmd>close<CR>', { noremap = true, silent = true, desc = 'Close Shell - ToggleTerm' })
    vim.api.nvim_buf_set_keymap(terminal.bufnr, 'n', '<Esc>', '<cmd>close<CR>', { noremap = true, silent = true, desc = 'Close Shell - ToggleTerm' })
    vim.api.nvim_buf_set_keymap(terminal.bufnr, 't', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Exit terminal mode - ToggleTerm' })
    vim.api.nvim_buf_set_keymap(terminal.bufnr, 't', '<C-\\>', '<cmd>close<CR>', { noremap = true, silent = true, desc = 'Close Shell - ToggleTerm' })
  end,
}

-- copilot
vim.keymap.set('n', '<leader>tc', require('custom.copilot_toggle').copilot_toggle, { desc = '[T]oggle [C]opilot' })

-- harpoon
exports.harpoon = {
  set_keymaps = function(harpoon)
    vim.keymap.set('n', '<leader>a', function()
      vim.print 'Pinned'
      harpoon:list():add()
    end, { desc = '[A]dd current file to Harpoon' })
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Open Harpoon window' })

    vim.keymap.set('n', '<C-H>', function()
      harpoon:list():select(1)
    end, { desc = 'Select Harpoon entry 1' })
    vim.keymap.set('n', '<C-J>', function()
      harpoon:list():select(2)
    end, { desc = 'Select Harpoon entry 2' })
    vim.keymap.set('n', '<C-K>', function()
      harpoon:list():select(3)
    end, { desc = 'Select Harpoon entry 3' })
    vim.keymap.set('n', '<C-L>', function()
      harpoon:list():select(4)
    end, { desc = 'Select Harpoon entry 4' })
  end,
}

-- undotree
vim.keymap.set('n', '<leader>tu', '<cmd>:UndotreeToggle<CR>:UndotreeFocus<CR>', { desc = '[T]oggle [U]ndotree' })

-- neo-tree
exports.neo_tree = {
  { '\\', ':Neotree position=left toggle=true<CR>', desc = 'Open NeoTree', silent = true },
}

-- lazygit
exports.lazygit = {
  { '<leader>og', '<cmd>LazyGit<cr>', desc = '[O]pen [G]it - LazyGit' },
}

-- conform
exports.conform = {
  keys = {
    {
      '<leader>tl',
      function()
        if vim.g.conform_format_on_save == 1 then
          vim.g.conform_format_on_save = 0
          vim.print 'format on save disabled'
        else
          vim.g.conform_format_on_save = 1
          vim.print 'format on save enabled'
        end
      end,
      mode = '',
      desc = '[T]oggle [L]ayout - Conform',
    },
    {

      '<leader>f',
      '<cmd>:w<CR>',
      mode = '',
      desc = '[F]ormat buffer - Conform',
    },
  },
}

-- telescope
exports.telescope = {
  set_keymaps = function(builtin)
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', function()
      builtin.find_files { hidden = true, no_ignore = true }
    end, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sb', builtin.builtin, { desc = '[S]earch Telescope [B]uiltin' })
    vim.keymap.set('n', '<leader>sg', function()
      builtin.grep_string {
        shorten_path = true,
        word_match = '-w',
        only_sort_text = true,
        search = '',
      }
    end, { desc = '[S]earch [G]rep' })

    vim.keymap.set('n', '<leader>se', function()
      builtin.live_grep { hidden = true, no_ignore = true }
    end, { desc = '[S]earch by Grep [E]xact' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sq', builtin.quickfix, { desc = '[S]earch [Q]uickfix' })
    vim.keymap.set('n', '<leader>s-', builtin.quickfixhistory, { desc = '[S]earch [-] Quickfix History' })

    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', function()
      builtin.oldfiles { hidden = true, no_ignore = true }
    end, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    vim.keymap.set('n', '<leader>sc', function()
      builtin.find_files { cwd = '~/.config/ubuntu/' }
    end, { desc = '[S]earch [C]onfig files' })
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}

--  multicursor
exports.multicursor = {
  {
    mode = 'n',
    '<leader>m',
    '<cmd>:MCunderCursor<cr>',
    desc = '[M]ulticursor',
  },
  {
    mode = 'v',
    '<leader>m',
    '<cmd>:MCstart<cr>',
    desc = '[M]ulticursor',
  },
}

-- live-server
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

-- doge
-- Generate comment for current line
vim.g.doge_mapping = '<Leader>od'

--trouble
exports.trouble = {
  {
    '<leader>xx',
    '<cmd>Trouble diagnostics toggle<cr>',
    desc = 'Diagnostics (Trouble)',
  },
  {
    '<leader>xX',
    '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
    desc = 'Buffer Diagnostics (Trouble)',
  },
  {
    '<leader>xs',
    '<cmd>Trouble symbols toggle focus=false<cr>',
    desc = 'Symbols (Trouble)',
  },
}
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Cellular Automaton

local function choose_random_kms()
  local kmss = {
    'swirl',
    'ripple',
    'rotate',
    'matrix',
    'random', --[['slide']]
    'game_of_life',
    'make_it_rain',
    'scramble',
  }
  local kms = kmss[math.random(1, #kmss)]
  vim.cmd('CellularAutomaton ' .. kms)
end
--[[
vim.cmd('CellularAutomaton ' .. 'swirl')
vim.cmd('CellularAutomaton ' .. 'ripple')
vim.cmd('CellularAutomaton ' .. 'rotate')
vim.cmd('CellularAutomaton ' .. 'matrix')
vim.cmd('CellularAutomaton ' .. 'random')

vim.cmd('CellularAutomaton ' .. 'game_of_life')
vim.cmd('CellularAutomaton ' .. 'make_it_rain')
vim.cmd('CellularAutomaton ' .. 'scramble')
vim.cmd('CellularAutomaton ' .. 'slide')
--]]

vim.keymap.set('n', '<leader>kms', choose_random_kms, { desc = '[K][M][S]' })
-- lsp-config
-- go to lsp-config file. It's too complicated to make sense to put here

return exports
