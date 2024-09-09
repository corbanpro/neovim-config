local exports = {}
-- helpers
vim.keymap.set('i', '<C-R>', '<C-G>u<C-R>', { desc = 'augmented paste' })
vim.keymap.set('n', '<CR>', 'o<ESC>', { desc = 'Insert newline below' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-q>', '<C-v>', { desc = 'enter visual block mode' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'scroll down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'scroll up' })
vim.keymap.set('n', '<C-Space>', '$', { desc = 'Move to end of line' })
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = '[P]aste over selection' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = '[D]elete without yanking' })
vim.keymap.set({ 'n', 'v' }, '<leader>x', [["_x]], { desc = '[X] Delete without yanking' })
vim.keymap.set('n', '<leader>el', '<cmd>:yank<cr>:lua <C-R>"<cr>', { desc = '[E]xecute in [L]ua' })

-- diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- replace
vim.keymap.set('n', '<leader>rp', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]e[P]lace inside cursor' })
vim.keymap.set('v', '<leader>rp', [["5y:%s/\<C-r>5/<C-r>5/gI<Left><Left><Left>]], { desc = '[R]e[P]lace inside cursor' })
vim.keymap.set('n', '<leader>rc', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]], { desc = '[R]eplace [C]onfirm inside cursor' })
vim.keymap.set('v', '<leader>rc', [["5y:%s/\<C-r>5/<C-r>5/gc<Left><Left><Left>]], { desc = '[R]eplace [C]onfirm inside cursor' })

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

-- ToggleTerm
vim.keymap.set('n', '<leader>os', '<cmd>:ToggleTerm direction=float<CR>', { desc = '[O]pen [S]hell - ToggleTerm' })
vim.keymap.set('n', '<leader>ofs', '<cmd>:ToggleTerm direction=float<CR>', { desc = '[O]pen [F]loat [S]hell - ToggleTerm' })
vim.keymap.set('n', '<leader>ovs', '<cmd>:ToggleTerm direction=vertical<CR>', { desc = '[O]pen [V]ertical [S]hell - ToggleTerm' })
vim.keymap.set('n', '<leader>ohs', '<cmd>:ToggleTerm direction=horizontal<CR>', { desc = '[O]pen [H]orizontal [S]hell - ToggleTerm' })
vim.keymap.set('n', '<leader>ows', '<cmd>:ToggleTerm direction=tab<CR>', { desc = '[O]pen [W]indow [S]hell - ToggleTerm' })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode - ToggleTerm' })
exports.toggleterm = {
  set_keymaps = function(terminal)
    vim.api.nvim_buf_set_keymap(terminal.bufnr, 'n', '<Esc>', '<cmd>close<CR>', { noremap = true, silent = true, desc = 'Close Shell - ToggleTerm' })
  end,
}

-- copilot
vim.keymap.set('n', '<leader>tc', require('custom.copilot_toggle').copilot_toggle, { desc = '[T]oggle [C]opilot' })

-- harpoon
exports.harpoon = {
  set_keymaps = function(harpoon)
    vim.keymap.set('n', '<leader>a', function()
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

    vim.keymap.set('n', '<C-up>', function()
      harpoon:list():prev()
    end, { desc = 'Select previous Harpoon entry' })
    vim.keymap.set('n', '<C-down>', function()
      harpoon:list():next()
    end, { desc = 'Select next Harpoon entry' })
  end,
}

-- undotree
exports.undotree = {
  set_keymaps = function()
    vim.keymap.set('n', '<leader>tu', '<cmd>:UndotreeToggle<CR>:UndotreeFocus<CR>', { desc = '[T]oggle [U]ndotree' })
  end,
}

-- neo-tree
exports.neo_tree = {
  { '\\', ':Neotree position=float %:p:h<CR>:set relativenumber<CR>', desc = 'Open NeoTree', silent = true },
  { '<C-\\>', ':Neotree position=left %:p:h<CR>:set relativenumber<CR>', desc = 'Open NeoTree', silent = true },
}

-- lazygit
exports.lazygit = {
  { '<leader>og', '<cmd>LazyGit<cr>', desc = '[O]pen [G]it - LazyGit' },
}

-- conform
exports.conform = {
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer - Conform',
    },
  },
}

-- telescope
exports.telescope = {
  set_keymaps = function(builtin)
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp - ' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    vim.keymap.set('n', '<leader>sc', function()
      builtin.git_files { cwd = '~/' }
    end, { desc = '[S]earch [C]onfig files' })
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}

-- lsp-config
-- go to lsp-config file. It's too complicated to make sense to put here

return exports
