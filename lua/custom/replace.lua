local exports = {}
function exports.n_replace_all()
  local word = vim.fn.expand '<cword>'
  local escaped_word = vim.fn.escape(word, '\\/.*$^~[]()')
  vim.cmd(':%s/' .. escaped_word .. '/' .. vim.fn.input('Replace "' .. word .. '" with: ', word) .. '/g')
  vim.cmd.normal(vim.api.nvim_replace_termcodes('<C-o>', true, true, true))
end

function exports.v_replace_all()
  vim.cmd 'normal! "zy'
  local selection = vim.fn.getreg 'z'
  local escaped_selection = vim.fn.escape(selection, '\\/.*$^~[]()')
  vim.cmd(':%s/' .. escaped_selection .. '/' .. vim.fn.input('Replace "' .. selection .. '" with: ', selection) .. '/g')
  vim.cmd.normal(vim.api.nvim_replace_termcodes('<C-o>', true, true, true))
end

function exports.n_replace_confirm_all()
  local word = vim.fn.expand '<cword>'
  local escaped_word = vim.fn.escape(word, '\\/.*$^~[]()')
  vim.cmd(':%s/' .. escaped_word .. '/' .. vim.fn.input('Replace <' .. word .. '> with: ', word) .. '/gc')
  vim.cmd.normal(vim.api.nvim_replace_termcodes('<C-o>', true, true, true))
end

function exports.v_replace_confirm_all()
  vim.cmd 'normal! "zy'
  local selection = vim.fn.getreg 'z'
  local escaped_selection = vim.fn.escape(selection, '\\/.*$^~[]()')
  vim.cmd(':%s/' .. escaped_selection .. '/' .. vim.fn.input('Replace <' .. selection .. '> with: ', selection) .. '/gc')
  vim.cmd.normal(vim.api.nvim_replace_termcodes('<C-o>', true, true, true))
end
return exports
