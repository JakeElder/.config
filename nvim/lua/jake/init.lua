require('jake.set')
require('jake.packer')
require('jake.remap')

-- Stop complaining when closing Netrw
vim.cmd([[autocmd FileType netrw setl bufhidden=wipe]])

-- Highlight cursor line on active window
vim.cmd([[
  augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
  augroup END
]])

-- Left and Right
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')

-- Close buffer
vim.keymap.set('n', '<C-c>', function() vim.cmd('BD') end)

-- Quit
vim.keymap.set('n', '<leader>q', function() vim.cmd('quit') end)
vim.keymap.set('n', '<leader>Q', function() vim.cmd('qall') end)

-- Write
vim.keymap.set('n', '<leader>w', function() vim.cmd('write') end)

-- Vertical split
vim.keymap.set('n', '<leader>v', ':vs<cr> <c-w><c-l>')

-- Stop "No information available" on hover
-- https://github.com/neovim/nvim-lspconfig/issues/1931
-- local banned_messages = { "No information available" }
-- vim.notify = function(msg, ...)
--   for _, banned in ipairs(banned_messages) do
--     if msg == banned then
--       return
--     end
--   end
--   require("notify")(msg, ...)
-- end

-- Window resizing
vim.keymap.set('n', '<leader><', '20<c-w><')
vim.keymap.set('n', '<leader>>', '20<c-w>>')
vim.keymap.set('n', '<leader>.', '<c-w>=')
