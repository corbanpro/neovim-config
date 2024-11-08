return {
  {
    'folke/which-key.nvim',
    opts = {
      icons = {
        mappings = vim.g.have_nerd_font,
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

        { '<leader>k', group = '[K][M][S]' },
        { '<leader>km', group = '[K][M][S]' },

        { '<leader>t', group = '[T]oggle' },
      },
    },
  },
}
