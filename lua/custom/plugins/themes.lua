local colorscheme_file_pth = vim.fn.stdpath 'data' .. '/colorscheme.txt'
local default_color_scheme = 'tokyonight-night'

local function file_exists(file)
  local f = io.open(file, 'rb')
  if f then
    f:close()
  end
  return f ~= nil
end

local function set_color_scheme(colorscheme)
  local file = io.open(colorscheme_file_pth, 'w')
  if not file then
    return
  end
  file:write(colorscheme)
  file:close()
end

local function get_color_scheme()
  if not file_exists(colorscheme_file_pth) then
    set_color_scheme(default_color_scheme)
  end
  local lines = {}
  for line in io.lines(colorscheme_file_pth) do
    lines[#lines + 1] = line
  end

  return lines[1]
end

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    print('Colorscheme changed to: ' .. vim.g.colors_name)
    set_color_scheme(vim.g.colors_name)
  end,
})

return {
  { 'rose-pine/neovim', priority = 1000, name = 'rose-pine' },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme(get_color_scheme())
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
}
