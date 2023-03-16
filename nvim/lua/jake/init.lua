vim.notify = require('notify')

require('jake.set')
require('jake.packer')
require('jake.remap')

vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')

vim.keymap.set('n', '<C-c>', function()
  vim.cmd('BD')
end)

vim.keymap.set('n', '<leader>q', function()
  vim.cmd('quit')
end)

vim.keymap.set('n', '<leader>Q', function()
  vim.cmd('qall')
end)

vim.keymap.set('n', '<leader>v', ':vs<cr> <c-w><c-l>')
