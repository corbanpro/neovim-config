vim.g.conform_format_on_save = 1

return {

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = require('custom.remap').conform.keys,
    opts = {
      formatters = {
        prettierd = {
          inherit = true,
          prepend_args = { '--print-width=100' },
        },
        prettier = {
          inherit = true,
          prepend_args = { '--print-width=100' },
        },
      },
      format_on_save = function(bufnr)
        if vim.g.conform_format_on_save == 0 then
          return false
        end

        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
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
        ['*'] = { 'trim_whitespace' },
      },
    },
  },
}
