local exports = {}
local find_replace_string = '\\/:.*$^~[]()'

function exports.n_replace_all()
  local word = vim.fn.expand '<cword>'
  local escaped_word = vim.fn.escape(word, find_replace_string)
  local replacement = vim.fn.input('Replace "' .. word .. '" with: ', word)
  local escaped_replacement = vim.fn.escape(replacement, find_replace_string)
  vim.cmd(':%s/' .. escaped_word .. '/' .. escaped_replacement .. '/g')
  vim.cmd.normal(vim.api.nvim_replace_termcodes('<C-o>', true, true, true))
end

function exports.v_replace_all()
  vim.cmd 'normal! "zy'
  local word = vim.fn.getreg 'z'
  local escaped_word = vim.fn.escape(word, find_replace_string)
  local replacement = vim.fn.input('Replace "' .. word .. '" with: ', word)
  local escaped_replacement = vim.fn.escape(replacement, find_replace_string)
  vim.cmd(':%s/' .. escaped_word .. '/' .. escaped_replacement .. '/g')
  vim.cmd.normal(vim.api.nvim_replace_termcodes('<C-o>', true, true, true))
end

function exports.n_replace_confirm_all()
  local word = vim.fn.expand '<cword>'
  local escaped_word = vim.fn.escape(word, find_replace_string)
  local replacement = vim.fn.input('Replace "' .. word .. '" with: ', word)
  local escaped_replacement = vim.fn.escape(replacement, find_replace_string)
  vim.cmd(':%s/' .. escaped_word .. '/' .. escaped_replacement .. '/g')
  vim.cmd.normal(vim.api.nvim_replace_termcodes('<C-o>', true, true, true))
end

function exports.v_replace_confirm_all()
  vim.cmd 'normal! "zy'
  local word = vim.fn.getreg 'z'
  local escaped_word = vim.fn.escape(word, find_replace_string)
  local replacement = vim.fn.input('Replace "' .. word .. '" with: ', word)
  local escaped_replacement = vim.fn.escape(replacement, find_replace_string)
  vim.cmd(':%s/' .. escaped_word .. '/' .. escaped_replacement .. '/g')
  vim.cmd.normal(vim.api.nvim_replace_termcodes('<C-o>', true, true, true))
end
return exports
