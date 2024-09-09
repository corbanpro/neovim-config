return {
  'github/copilot.vim',
  config = function()
    local copilot_mod = require 'custom.copilot_toggle'
    if copilot_mod.copilot_on() then
      copilot_mod.set_copilot 'true'
    else
      copilot_mod.set_copilot 'false'
    end
  end,
}

-- return {

--   'zbirenbaum/copilot.lua',
--   cmd = 'Copilot',
--   event = 'InsertEnter',
--   config = true,
--
--   otps = {
--     panel = {
--       enabled = true,
--       auto_refresh = false,
--       keymap = {
--         jump_prev = '[[',
--         jump_next = ']]',
--         accept = '<CR>',
--         refresh = 'gr',
--         open = '<M-CR>',
--       },
--       layout = {
--         position = 'bottom', -- | top | left | right
--         ratio = 0.4,
--       },
--     },
--     suggestion = {
--       enabled = true,
--       auto_trigger = false,
--       -- hide_during_completion = true,
--       hide_during_completion = false,
--       debounce = 75,
--       keymap = {
--         accept = '<M-l>',
--         accept_word = false,
--         accept_line = false,
--         next = '<M-]>',
--         prev = '<M-[>',
--         dismiss = '<C-]>',
--       },
--     },
--     filetypes = {
--       yaml = false,
--       markdown = false,
--       help = false,
--       gitcommit = false,
--       gitrebase = false,
--       hgcommit = false,
--       svn = false,
--       cvs = false,
--       ['.'] = false,
--     },
--     -- copilot_node_command = 'node', -- Node.js version must be > 18.x
--     -- server_opts_overrides = {},
--   },
-- }
