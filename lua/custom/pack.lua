local function require_all(dir)
  local files = vim.fn.glob(dir .. '/*.lua', false, true)
  for _, file in ipairs(files) do
    local module = file:gsub('^' .. vim.pesc(dir) .. '/', ''):gsub('%.lua$', '')
    require(dir .. '.' .. module)
  end
end

require_all 'lua/custom/plugins-pack'
