-- DONE:
return {
  cmd = { 'bash-language-server', 'start' },
  root_markers = { '.' },
  filetypes = { 'sh' },
  settings = {
    bashIde = {
      globPattern = '*@(.sh|.inc|.bash|.command)',
    },
  },
}
