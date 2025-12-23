return {
  {
    'ziontee113/icon-picker.nvim',
    cmd = { 'IconPickerNormal', 'IconPickerYank', 'IconPickerInsert' },
    keys = {
      {
        '<leader>ii',
        ':IconPickerNormal<CR>',
        desc = 'Insert [I]con',
      },
    },
    opts = {
      -- disable_legacy_commands = true,
    },
  },
}
