return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>e', group = '[E]xecute' },
        { '<leader>b', group = '[B]uffer' },
        { '<leader>r', group = '[R]eplace' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },

        { '<leader>o', group = '[O]pen' },
        { '<leader>ov', group = '[O]pen [V]ertical' },
        { '<leader>oh', group = '[O]pen [H]orizontal' },
        { '<leader>of', group = '[O]pen [F]loat' },
        { '<leader>ow', group = '[O]pen [W]indow' },

        { '<leader>t', group = '[T]oggle' },
        { '<leader>tv', group = '[T]oggle [V]ertical' },
        { '<leader>th', group = '[T]oggle [H]orizontal' },
        { '<leader>tf', group = '[T]oggle [F]loat' },
        { '<leader>tw', group = '[T]oggle [W]indow' },
      },
    },
  },
}
