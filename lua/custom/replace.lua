local exports = {}
local find_replace_string = '\\/:.*$;#^[]()'

function exports.n_replace_all()
  local word = vim.fn.expand '<cword>'
  local escaped_word = vim.fn.escape(word, find_replace_string)
  local replacement = vim.fn.input('Replace "' .. word .. '" with: ', word)
  if replacement == '' then
    return
  end
  local escaped_replacement = vim.fn.escape(replacement, find_replace_string)
  local vim_cmd = ':%sno/' .. escaped_word .. '/' .. escaped_replacement .. '/g'
  vim.cmd(vim_cmd)
  print(vim_cmd)
end

function exports.v_replace_all()
  vim.cmd 'normal! "zy'
  local word = vim.fn.getreg 'z'
  local escaped_word = vim.fn.escape(word, find_replace_string)
  local replacement = vim.fn.input('Replace "' .. word .. '" with: ', word)
  if replacement == '' then
    return
  end
  local escaped_replacement = vim.fn.escape(replacement, find_replace_string)
  local vim_cmd = ':%sno/' .. escaped_word .. '/' .. escaped_replacement .. '/g'
  vim.cmd(vim_cmd)
  print(vim_cmd)
end

function exports.n_replace_confirm_all()
  local word = vim.fn.expand '<cword>'
  local escaped_word = vim.fn.escape(word, find_replace_string)
  local replacement = vim.fn.input('Replace "' .. word .. '" with: ', word)
  if replacement == '' then
    return
  end
  local escaped_replacement = vim.fn.escape(replacement, find_replace_string)
  local vim_cmd = ':%sno/' .. escaped_word .. '/' .. escaped_replacement .. '/gc'
  vim.cmd(vim_cmd)
  print(vim_cmd)
end

function exports.v_replace_confirm_all()
  vim.cmd 'normal! "zy'
  local word = vim.fn.getreg 'z'
  local escaped_word = vim.fn.escape(word, find_replace_string)
  local replacement = vim.fn.input('Replace "' .. word .. '" with: ', word)
  if replacement == '' then
    return
  end
  local escaped_replacement = vim.fn.escape(replacement, find_replace_string)
  local vim_cmd = ':%sno/' .. escaped_word .. '/' .. escaped_replacement .. '/gc'
  vim.cmd(vim_cmd)
  print(vim_cmd)
end
return exports
