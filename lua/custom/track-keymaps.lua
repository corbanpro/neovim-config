local keymap_encountered = {} -- used to make sure no duplicates are inserted into keymaps_table
local keymaps_table = {}
local max_len_lhs = 0
local modes = { 'n', 'i', 'c', 'x' }
local map_usage = {}

local function display_termcodes(str)
  return str:gsub(string.char(9), '<TAB>'):gsub('', '<C-F>'):gsub(' ', '<Space>'):gsub('', '<C-a>')
end

-- helper function to populate keymaps_table and determine max_len_lhs
local function extract_keymaps(keymaps)
  for _, keymap in pairs(keymaps) do
    local keymap_key = keymap.buffer .. keymap.mode .. keymap.lhs -- should be distinct for every keymap
    if not keymap_encountered[keymap_key] then
      keymap_encountered[keymap_key] = true
      if not string.find(keymap.lhs, '<Plug>') then
        table.insert(keymaps_table, keymap)
        max_len_lhs = math.max(max_len_lhs, #display_termcodes(keymap.lhs))
      end
    end
  end
end

local group = vim.api.nvim_create_augroup('GetKeyMaps', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = group,
  callback = function()
    keymaps_table = {}
    for _, mode in pairs(modes) do
      local global = vim.api.nvim_get_keymap(mode)
      local buf_local = vim.api.nvim_buf_get_keymap(0, mode)
      extract_keymaps(global)
      extract_keymaps(buf_local)
    end
  end,
})

local function log_key(key, typed)
  -- key = display_termcodes(key)
  if not map_usage[key] then
    map_usage[key] = 16
  end
  map_usage[key] = map_usage[key] + 1
  vim.notify(key .. ' pressed ' .. map_usage[key] .. ' times')
end

function Open_table_buffer(tbl)
  -- convert all entries to strings
  local lines = {}
  for _, v in ipairs(tbl) do
    local inspected = vim.inspect(v)
    -- split by newline to handle nested tables
    for line in inspected:gmatch '[^\r\n]+' do
      table.insert(lines, line)
    end
  end

  -- create new empty scratch buffer
  local buf = vim.api.nvim_create_buf(false, true) -- listed=false, scratch=true

  -- set the buffer contents
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- open in a new window
  vim.api.nvim_set_current_buf(buf)
end

vim.api.nvim_create_user_command(
  'KeyReport', -- the name of your command
  function() -- callback function that runs when command is called
    Open_table_buffer(map_usage)
  end,
  { nargs = 0 } -- optional settings
)

vim.on_key(log_key)
Open_table_buffer(keymaps_table)
