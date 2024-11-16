return {
  {
    'axelvc/template-string.nvim',
    opts = {
      filetypes = { 'html', 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue', 'svelte', 'python' },
      jsx_brackets = true,
      remove_template_string = false,
      restore_quotes = {
        normal = [["]],
        jsx = [["]],
      },
    },
  },
}
