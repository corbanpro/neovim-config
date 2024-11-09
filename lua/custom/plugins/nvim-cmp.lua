return {
  { 'nvim-lua/plenary.nvim', lazy = true },
  { -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    build = (function()
      if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
        return
      end
      return 'make install_jsregexp'
    end)(),
  },
  {
    'saadparwaiz1/cmp_luasnip',
    event = 'InsertEnter',
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    event = 'InsertEnter',
  },
  {
    'hrsh7th/cmp-path',
    event = 'InsertEnter',
  },
  {
    'Jezda1337/nvim-html-css',
    event = 'InsertEnter',
    config = function()
      require('html-css'):setup()
    end,
  },
  {
    'rafamadriz/friendly-snippets',
    event = 'InsertEnter',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}
      local types = require 'cmp.types'

      local function deprioritize_snippet(entry1, entry2)
        if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
          return false
        end
        if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
          return true
        end
      end

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        sorting = {
          priority_weight = 1,
          comparators = {
            deprioritize_snippet,
            cmp.config.compare.exact,
            cmp.config.compare.score,
          },
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          {
            name = 'lazydev',
            group_index = 0,
          },
          {
            name = 'html-css',
            option = {
              enable_on = {
                'html',
                'css',
                'javascriptreact',
                'typescriptreact',
                'javascript.jsx',
                'typescript.jsx',
              },
              file_extensions = { 'css' },
              style_sheets = {},
            },
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'volar' },
          { name = 'yamlls' },
        },
      }
    end,
  },
}
