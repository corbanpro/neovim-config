local exports = {}

function exports.insert_symbolic_link()
  local filetype = vim.bo[vim.api.nvim_get_current_buf()].filetype
  if filetype ~= 'sh' and filetype ~= 'python' then
    vim.print('invalid file type: ' .. filetype)
    return
  end

  local src = vim.fn.expand '%:p'
  local dest = '~/.local/bin/' .. string.match(vim.fn.expand '%:t', '^[^.]+')
  local perm_cmd = 'chmod a+x ' .. src
  local rm_cmd = 'rm -f ' .. dest
  local add_cmd = 'ln -s ' .. src .. ' ' .. dest

  os.execute(perm_cmd)
  os.execute(rm_cmd)
  os.execute(add_cmd)
  vim.print('created file: ' .. dest)
end

return exports
