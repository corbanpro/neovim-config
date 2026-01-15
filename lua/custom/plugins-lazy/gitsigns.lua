return {
  { 'petertriho/nvim-scrollbar' },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        signs_staged_enable = true,
        current_line_blame_opts = {
          virt_text_pos = 'right_align',
          virt_text_priority = 5000,
          delay = 0,
        },

        on_attach = function(bufnr)
          local gitsigns = require 'gitsigns'

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']h', function()
            --- @diagnostic disable-next-line: param-type-mismatch
            gitsigns.nav_hunk 'next'
          end, { desc = 'Jump to next [h]unk' })

          map('n', '[h', function()
            --- @diagnostic disable-next-line: param-type-mismatch
            gitsigns.nav_hunk 'prev'
          end, { desc = 'Jump to previous [h]unk' })

          -- Actions
          -- visual mode
          map('v', '<leader>hs', function()
            gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'git [s]tage hunk' })
          map('v', '<leader>hr', function()
            gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'git [r]eset hunk' })
          -- normal mode
          map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Git [S]tage Hunk' })
          map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Git [R]eset Hunk' })
          map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Git [S]tage Buffer' })
          map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Git [R]eset Buffer' })
          map('n', '<leader>hp', gitsigns.preview_hunk_inline, { desc = 'Git [P]review Hunk Inline' })
          map('n', '<leader>hP', gitsigns.preview_hunk, { desc = 'Git [P]review Hunk' })
          map('n', '<leader>hb', gitsigns.blame, { desc = 'Git [B]lame' })
          map('n', '<leader>hl', gitsigns.blame_line, { desc = 'Git blame [L]ine' })
          map('n', '<leader>hL', function()
            gitsigns.blame_line { full = true }
          end, { desc = 'Git blame [L]ine with diff' })

          map('n', '<leader>hd', function()
            local buffers = vim.api.nvim_list_bufs()
            local deleted = false
            for _, buf in ipairs(buffers) do
              local name = vim.api.nvim_buf_get_name(buf)
              if string.find(name, 'gitsigns:///') then
                vim.api.nvim_buf_delete(buf, { force = true })
                deleted = true
              end
            end
            if not deleted then
              --- @diagnostic disable-next-line: param-type-mismatch
              gitsigns.diffthis '@'
            end
          end, { desc = 'Git [D]iff against last commit' })

          map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)

          map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle Current Line [B]lame' })
        end,
      }
      require('scrollbar.handlers.gitsigns').setup()
    end,
  },
}
