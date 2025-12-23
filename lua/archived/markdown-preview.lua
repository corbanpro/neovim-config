return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = 'cd app && yarn install',
    keys = {
      {
        '<leader>op',
        '<cmd>:MarkdownPreview<CR>',
        desc = '[O]pen Markdown [P]review',
      },
      init = function()
        vim.g.mkdp_filetypes = { 'markdown' }
        vim.g.mkdp_auto_close = 0
      end,
    },
  },
}
