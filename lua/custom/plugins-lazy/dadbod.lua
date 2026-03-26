vim.g.db_ui_table_helpers = {
  postgresql = {
    Columns = [[select table_name, column_name, data_type, column_default, is_nullable from information_schema.columns where table_name='chat_settings' and table_schema='public']],
  },
}

return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    {
      'tpope/vim-dotenv',
      lazy = true,
      config = function()
        vim.cmd 'Dotenv ~/.config/nvim/.env'
      end,
    },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_winwidth = 50
    vim.g.db_ui_auto_execute_table_helpers = 1
  end,
  config = function()
    vim.g.dbs = {
      { name = 'local_df', url = vim.env.LOCAL_DF_URL },
      { name = 'beta_df', url = vim.env.BETA_DF_URL },
      { name = 'prod_df', url = vim.env.PROD_DF_URL },
      { name = 'local_cm', url = vim.env.LOCAL_CM_URL },
      { name = 'beta_cm', url = vim.env.BETA_CM_URL },
      { name = 'prod_cm', url = vim.env.PROD_CM_URL },
    }
  end,
}
