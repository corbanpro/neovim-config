return {
  {

    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    opts = {},
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
        '<leader>st',
        '<cmd>:FzfLua tabs<CR>',
        desc = '[S]earch [T]abs',
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
