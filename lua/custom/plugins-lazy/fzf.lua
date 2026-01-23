local function search_projects()
  local fzf_lua = require 'fzf-lua'

  fzf_lua.fzf_exec(
    [[ fd --hidden Session.vim ~/.local/share/nvim/sessions/ | sed "s|.*/share/nvim/sessions/||; s|/Session.vim$||; s|Users/corbanprocuniar|~|" ]],
    {
      hidden = true,
      actions = {
        ['default'] = function(selected_files)
          local old_session_path = '~/.local/share/nvim/sessions' .. vim.fn.getcwd()
          vim.cmd('silent! !mkdir -p ' .. old_session_path)
          vim.cmd('mksession! ' .. old_session_path .. '/Session.vim')
          local new_cwd = selected_files[1]
          new_cwd = vim.fn.expand(new_cwd)
          local session_file = '~/.local/share/nvim/sessions' .. new_cwd .. '/Session.vim'
          vim.cmd.cd(new_cwd)
          vim.cmd.source(session_file)
        end,
        ['ctrl-x'] = {
          function(selected)
            for _, f in ipairs(selected) do
              f = vim.fn.expand(f)
              vim.fn.delete(f)
              local session_file = '~/.local/share/nvim/sessions' .. f .. '/Session.vim'
              vim.cmd('!rm ' .. session_file)
            end
          end,
          require('fzf-lua').actions.resume,
        },
      },
    }
  )
end

return {
  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    opts = {
      files = {
        fd_opts = [[ --no-ignore-vcs --color=never --hidden --type f --type l --exclude .git -E "*_templ.go" ]],
      },
      grep = {
        rg_opts = [[ --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -g "!**/vendor/**" -e ]],
      },
    },
    keys = {
      -- files
      {
        '<leader>sf',
        '<cmd>:FzfLua files<CR>',
        desc = '[S]earch [F]iles',
      },
      {
        '<leader>sr',
        '<cmd>:FzfLua resume<CR>',
        desc = '[S]earch [R]esume',
      },
      {
        '<leader>s.',
        '<cmd>:FzfLua oldfiles<CR>',
        desc = '[S]earch Recent Files ("." for repeat)',
      },
      {
        '<leader><leader>',
        '<cmd>:FzfLua buffers<CR>',
        desc = '[ ] Find existing buffers',
      },
      {
        '<leader>sq',
        '<cmd>:FzfLua quickfix<CR>',
        desc = '[S]earch [Q]uickfix',
      },
      {
        '<leader>sn',
        '<cmd>:FzfLua files cwd=~/.config/nvim/<CR>',
        desc = '[S]earch [N]eovim Files',
      },
      {
        '<leader>ss',
        '<cmd>:FzfLua git_status<CR>',
        desc = '[S]earch Git [S]tatus',
      },
      {
        '<leader>sp',
        search_projects,
        desc = 'Search [P]rojects',
      },

      --search
      {
        '<leader>sg',
        '<cmd>:FzfLua live_grep<CR><C-g>',
        desc = '[S]earch [G]rep',
      },
      {
        mode = 'v',
        '<leader>sg',
        '<cmd>:lua FzfLua.live_grep { search = FzfLua.utils.get_visual_selection() }<CR><C-g>',
        desc = '[S]earch [G]rep',
      },
      {
        '<leader>se',
        '<cmd>:FzfLua live_grep<CR>',
        desc = '[S]earch [E]xact',
      },
      {
        mode = 'v',
        '<leader>se',
        '<cmd>:lua FzfLua.live_grep { search = FzfLua.utils.get_visual_selection() }<CR>',
        desc = '[S]earch [E]xact',
      },
      {
        '<leader>sb',
        '<cmd>:FzfLua builtin<CR>',
        desc = '[S]earch [B]uiltin',
      },
      {
        '<leader>/',
        '<cmd>:FzfLua lgrep_curbuf<CR>',
        desc = '[/] Search Current Buffer',
      },
      {
        mode = 'v',
        '<leader>/',
        '<cmd>:lua FzfLua.lgrep_curbuf { search = FzfLua.utils.get_visual_selection() }<CR>',
        desc = '[/] Search Current Buffer',
      },

      --extras
      {
        '<leader>sjc',
        '<cmd>:FzfLua colorschemes<CR>',
        desc = '[S]earch [J] [C]olor Scheme',
      },
      {
        '<leader>sjv',
        '<cmd>:FzfLua commands<CR>',
        desc = '[S]earch [J] [V]im Commands',
      },
    },
  },
}
