-- Autoformat
return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = { 'ConformInfo' },
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
