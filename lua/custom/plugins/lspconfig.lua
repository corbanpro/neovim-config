return {
  --dependencies
  {
    'saghen/blink.cmp',
    lazy = true,
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    lazy = true,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc .. ' - LSP' })
          end
          -- TODO: if filetype is go, use normal lsp go to definition
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('gt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
          -- map('<leader>ss', require('telescope.builtin').lsp_document_symbols, '[S]earch Document [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ea', vim.lsp.buf.code_action, '[E]xecute Code [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>ti', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle [I]nlay Hints')
          end
        end,
      })

      local servers = {
        htmx = {},
        templ = {},
        gopls = {},
        tailwindcss = {
          filetypes = { 'templ', 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
        },
        html = {},
        cssls = {
          settings = {
            css = {
              validate = true,
              lint = {
                unknownAtRules = 'ignore',
              },
            },
            scss = {
              validate = true,
              lint = {
                unknownAtRules = 'ignore',
              },
            },
            less = {
              validate = true,
              lint = {
                unknownAtRules = 'ignore',
              },
            },
          },
        },
        eslint = {},
        emmet_ls = {
          filetypes = { 'templ', 'html', 'css', 'javascript', 'typescript', 'vue', 'javascriptreact', 'typescriptreact' },
        },
        jedi_language_server = {},
        rust_analyzer = {

          -- handlers = {
          --   ['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          --     virtual_text = { prefix = '', spacing = 0 },
          --     signs = true,
          --     underline = true,
          --     update_in_insert = true,
          --   }),
          -- },

          settings = {
            ['rust-analyzer'] = {
              checkOnSave = {
                command = 'clippy',
              },
              cargo = {
                loadOutDirsFromCheck = true,
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
        ts_ls = {
          -- TODO: get rid of this when a pr gets merged into lsp-config. Probably in a few days
          root_dir = function(bufnr, on_dir)
            local root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' }
            local project_root = vim.fs.root(bufnr, root_markers)
            on_dir(project_root)
          end,
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      local global_capabilities = require('blink.cmp').get_lsp_capabilities()

      for name, config in pairs(servers) do
        config.capabilities = vim.tbl_deep_extend('force', {}, global_capabilities, config.capabilities or {})
        vim.lsp.config(name, config or {})
        vim.lsp.enable(name)
      end
    end,
  },
}
