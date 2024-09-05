return {

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
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
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
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
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        markdown = { 'prettier' },
        javascript = { 'prettier' },
      },
    },
  },
}
