local keymap_encountered = {} -- used to make sure no duplicates are inserted into keymaps_table
Keymaps_table = {}
local modes = { 'n', 'i', 'c', 'x', 'v' }
local map_usage = {}
local keymap_tri = {}

local function display_termcodes(str)
  return str:gsub(string.char(9), '<TAB>'):gsub('', '<C-F>'):gsub(' ', '<Space>'):gsub('', '<C-a>')
end

local function extract_keymaps(keymaps)
  for _, keymap in pairs(keymaps) do
    local keymap_key = keymap.buffer .. keymap.mode .. keymap.lhs -- should be distinct for every keymap
    if not keymap_encountered[keymap_key] then
      keymap_encountered[keymap_key] = true
      if not string.find(keymap.lhs, '<Plug>') then
        table.insert(Keymaps_table, keymap)
      end
    end
  end
end

local function get_word_table(lhs)
  local word_table = {}
  local inside_code = false
  local current_code = ''
  for char in lhs:gmatch '.' do
    if not inside_code and char ~= '<' then
      table.insert(word_table, char)
    end

    if char == '<' then
      inside_code = true
    end

    current_code = current_code .. char

    if char == '>' then
      inside_code = false
      table.insert(word_table, current_code)
    end
  end
  return word_table
end

local function construct_tri()
  keymap_tri.n = {}
  keymap_tri.i = {}
  keymap_tri.c = {}
  keymap_tri.x = {}

  for _, keymap in pairs(Keymaps_table) do
    local word_table = get_word_table(keymap.lhs)

    local node = keymap_tri[keymap.mode]
    for i, c in pairs(word_table) do
      if node == nil then
        node = {}
      end

      if c == ' ' then
        c = '<Space>'
      end

      if node[c] == nil then
        node[c] = {}
      end

      if i == #word_table then
        node[c].leaf = true
      end

      node = node[c]
    end
  end
end

local group = vim.api.nvim_create_augroup('GetKeyMaps', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = group,
  callback = function()
    for _, mode in pairs(modes) do
      local global = vim.api.nvim_get_keymap(mode)
      local buf_local = vim.api.nvim_buf_get_keymap(0, mode)
      extract_keymaps(global)
      extract_keymaps(buf_local)
      construct_tri()
    end
  end,
})

local function log_key(key, _)
  -- key = display_termcodes(key)
  if key == ' ' then
    key = '<Space>'
  end
  if not map_usage[key] then
    map_usage[key] = 0
  end
  map_usage[key] = map_usage[key] + 1
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

local function dfs(node, verteces, depth)
  local depth_chars = ''
  for _ = 1, depth do
    depth_chars = depth_chars .. '#'
  end
  for k, v in pairs(node) do
    if k == 'leaf' then
      return verteces
    end
    table.insert(verteces, depth_chars .. k)
    dfs(v, verteces, depth + 1)
  end
  return verteces
end

vim.api.nvim_create_user_command(
  'KeyReport',
  function()
    construct_tri()
    local lines = dfs(keymap_tri, {}, 1)

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_set_current_buf(buf)
  end,
  { nargs = 0 } -- optional settings
)

vim.on_key(log_key)
