-- install with yarn or npm
return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && npm install',
  keys = {
    {
      '<leader>tp',
      '<cmd>:MarkdownPreviewToggle<CR>',
      desc = '[T]oggle Markdown [P]review',
    },
  },
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
  ft = { 'markdown' },
}
