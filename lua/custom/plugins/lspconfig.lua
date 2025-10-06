local function get_pos(func)
  local ts_query = '(component_declaration name: (component_identifier) @func_name)'
  local ts_lang = 'templ'
  local parser = vim.treesitter.get_parser(0, ts_lang)
  if not parser then
    return nil
  end
  local tstree = parser:parse()[1]
  local node = tstree:root()
  local query = vim.treesitter.query.parse(ts_lang, ts_query)
  for _, func_name_node in query:iter_captures(node, 0) do
    local func_name = vim.treesitter.get_node_text(func_name_node, 0)
    if func_name == func then
      local start_row, start_col, _ = func_name_node:start()
      return start_row, start_col
    end
  end
end

local function goto_definition(func)
  local row, col = get_pos(func)
  if not row or not col then
    vim.api.nvim_command('silent! /templ ' .. func)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('0w', true, false, true), 'n', false)
    return
  end
  vim.api.nvim_win_set_cursor(0, { row + 1, col })
  vim.cmd 'DelJump'
end

local function templ_definition(og_func)
  return function(opts)
    og_func(opts)
    vim.defer_fn(function()
      -- get curent filename based off cursor location
      local filename = vim.api.nvim_buf_get_name(0)

      -- if filename ends with *_templ.go, then continure, else return
      if not filename:match '_templ%.go$' then
        return
      end
      local templ_filename = filename:gsub('_templ%.go$', '.templ')

      if templ_filename then
        local func = vim.fn.expand '<cword>'
        local options = { items = { { filename = templ_filename } } }
        vim.fn.setqflist({}, ' ', options)
        vim.api.nvim_command 'cfirst'
        goto_definition(func)
      end
    end, 50)
  end
end

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
          local ft = vim.bo[event.buf].filetype
          local builtin = require 'telescope.builtin'

          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc .. ' - LSP' })
          end

          local theme = require('telescope.themes').get_cursor {
            layout_config = {
              width = 200,
              preview_width = 0.55,
              height = 15,
            },
            sorter = require('telescope.sorters').get_substr_matcher(),
            winblend = 10,
            previewer = true,
            show_line = false,
            path_display = {
              'smart',
              'truncate',
            },
          }

          local custom_picker_overrides = {
            lua = {
              lsp_definitions = builtin.lsp_implementations,
            },
            go = {
              lsp_definitions = templ_definition(builtin.lsp_definitions),
            },
          }

          local function map_lsp(mapping, function_name, desc)
            map(mapping, function()
              if custom_picker_overrides[ft] and custom_picker_overrides[ft][function_name] then
                custom_picker_overrides[ft][function_name](theme)
              else
                builtin[function_name](theme)
              end
            end, desc)
          end

          map_lsp('gd', 'lsp_definitions', '[G]oto [D]efinition')
          map_lsp('gr', 'lsp_references', '[G]oto [R]eferences')
          map_lsp('gi', 'lsp_implementations', '[G]oto [I]mplementation')
          map_lsp('gt', 'lsp_type_definitions', '[G]oto [T]ype Definition')

          -- map('<leader>ss', require('telescope.builtin').lsp_document_symbols, '[S]earch Document [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, 'Re[N]ame')
          map('<leader>ea', vim.lsp.buf.code_action, 'Execute Code [A]ction', { 'n', 'x' })
          -- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            --- @diagnostic disable-next-line: param-type-mismatch
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            --- @diagnostic disable-next-line: param-type-mismatch
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
        sourcekit = {
          cmd = { 'xcrun', 'sourcekit-lsp' },
        },
        bashls = {},
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
