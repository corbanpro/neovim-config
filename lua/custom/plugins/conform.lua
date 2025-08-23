-- Autoformat
return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = { 'ConformInfo' },
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
        function()
          require('conform').format()
          vim.cmd 'w'
        end,
        mode = '',
        desc = '[F]ormat buffer - Conform',
      },
    },
    opts = {
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        sh = { 'shfmt' },
        markdown = { 'prettierd', 'prettier' },
        javascript = { 'prettierd', 'prettier' },
        javascriptreact = { 'prettierd', 'prettier' },
        typescript = { 'prettierd', 'prettier' },
        typescriptreact = { 'prettierd', 'prettier' },
        json = { 'prettierd', 'prettier' },
        html = { 'prettierd', 'prettier' },
        vue = { 'prettierd' },
        python = { 'black' },
        rust = { 'rustfmt' },
        yaml = { 'prettierd', 'prettier' },
        css = { 'prettierd', 'prettier' },
        go = { 'gofmt' },
        templ = { 'templ' },
        ['*'] = { 'trim_whitespace' },
      },
    },
  },
}
