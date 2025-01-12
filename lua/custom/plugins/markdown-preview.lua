-- install with yarn or npm
return {
  'iamcco/markdown-preview.nvim',
  event = 'BufRead',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && npm install',
  keys = {
    {
      '<leader>op',
      '<cmd>:MarkdownPreview<CR>',
      desc = '[O]pen Markdown [P]review',
    },
  },
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
    vim.g.mkdp_auto_close = 0
  end,
  ft = { 'markdown' },
}
