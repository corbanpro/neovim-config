return {
  --dependencies
  {
    'williamboman/mason-registry',
    lazy = true,
  },
  {
    'nvim-java/nvim-java',
  },
  {
    'b0o/schemastore.nvim',
    lazy = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = true,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    lazy = true,
  },
  {
    'j-hui/fidget.nvim',
    opts = {},
    lazy = true,
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    lazy = true,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc .. ' - LSP' })
          end
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('gt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
          map('<leader>ss', require('telescope.builtin').lsp_document_symbols, '[S]earch Document [S]ymbols')
          map('<leader>sw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]earch [W]orkspace Symbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ea', vim.lsp.buf.code_action, '[E]xecute Code [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>ti', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle [I]nlay Hints')
          end
        end,
      })
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      local mason_registry = require 'mason-registry'
      local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
      local servers = {
        templ = {},
        gopls = {},
        tailwindcss = {},
        omnisharp = {
          settings = {
            FormattingOptions = {
              EnableEditorConfigSupport = true,
            },
          },
        },
        bashls = {},
        jdtls = {},
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
          filetypes = { 'html', 'css', 'javascript', 'typescript', 'vue', 'javascriptreact', 'typescriptreact' },
        },
        jedi_language_server = {},
        volar = {},

        yamlls = {
          settings = {
            yaml = {
              customTags = {
                '!Base64 scalar',
                '!Cidr scalar',
                '!And sequence',
                '!Equals sequence',
                '!If sequence',
                '!Not sequence',
                '!Or sequence',
                '!Condition scalar',
                '!FindInMap sequence',
                '!GetAtt sequence',
                '!GetAZs scalar',
                '!ImportValue scalar',
                '!Join sequence',
                '!Select sequence',
                '!Split sequence',
                '!Sub scalar',
                '!Transform mapping',
                '!Ref scalar',
              },
              validate = true,
              hover = true,
              completion = true,
              format = {
                singleQuote = true,
                bracketSpacing = false,
              },
              schemaStore = {
                enable = false,
                url = '',
              },
              schemas = require('schemastore').json.schemas(),
            },
          },
        },
        rust_analyzer = {

          handlers = {
            ['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
              virtual_text = { prefix = '', spacing = 0 },
              signs = true,
              underline = true,
              update_in_insert = true,
            }),
          },

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
          init_options = {
            plugins = {
              {
                name = '@vue/typescript-plugin',
                location = vue_language_server_path,
                languages = { 'vue' },
              },
            },
          },
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
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
      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'google-java-format',
        'black',
        'stylua',
        'prettierd',
        'prettier',
        'shfmt',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
