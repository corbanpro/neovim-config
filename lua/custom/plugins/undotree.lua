return {
  {
    'mbbill/undotree',
    cmd = {
      'UndotreeFocus',
      'UndotreeToggle',
      'UndotreeHide',
    },
    keys = {
      {
        '<leader>tu',
        '<cmd>:UndotreeToggle<CR>:UndotreeFocus<CR>',
        desc = '[T]oggle [U]ndotree',
      },
    },
  },
}
