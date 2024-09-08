return {

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = require('custom.remap').conform.keys,
    opts = {
      formatters = {
        prettier = {
          arrow_parens = 'always',
          bracket_spacing = true,
          bracket_same_line = false,
          embedded_language_formatting = 'auto',
          end_of_line = 'lf',
          html_whitespace_sensitivity = 'css',
          -- jsx_bracket_same_line = false,
          jsx_single_quote = false,
          print_width = 40,
          prose_wrap = 'preserve',
          quote_props = 'as-needed',
          semi = false,
          single_attribute_per_line = false,
          single_quote = false,
          tab_width = 2,
          trailing_comma = 'es5',
          use_tabs = false,
          vue_indent_script_and_style = false,
        },
      },

      notify_on_error = false,
      format_on_save = function(bufnr)
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
        markdown = { 'prettier' },

        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
      },
    },
  },
}
