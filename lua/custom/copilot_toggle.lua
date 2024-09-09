local mod = {}

local copilot_on_file = vim.fn.stdpath 'config' .. '/lua/custom/copilot_on.txt'
local function file_exists(file)
  local f = io.open(file, 'rb')
  if f then
    f:close()
  end
  return f ~= nil
end

local function copilot_on()
  if not file_exists(copilot_on_file) then
    local file = io.open(copilot_on_file, 'w')
    if not file then
      return false
    end
    file:write 'false'
    file:close()
    return false
  end
  local lines = {}
  for line in io.lines(copilot_on_file) do
    lines[#lines + 1] = line
  end

  return lines[1] == 'true' and true or false
end

local function set_copilot(state)
  local f = io.open(copilot_on_file, 'w')
  if not f then
    return
  end
  f:write(state)
  f:close()
  if state == 'false' then
    vim.cmd 'Copilot disable'
    vim.print 'Copilot disabled'
  else
    vim.cmd 'Copilot enable'
    vim.print 'Copilot enabled'
  end
end

local copilot_toggle = function()
  if copilot_on() then
    set_copilot 'false'
  else
    set_copilot 'true'
  end
end

mod.copilot_on = copilot_on
mod.copilot_toggle = copilot_toggle
mod.set_copilot = set_copilot

return mod
