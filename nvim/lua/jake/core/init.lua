require("jake.core.options")
require("jake.core.keymaps")

-- Only show cursor line on active window
vim.cmd([[
  augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
  augroup END
]])
