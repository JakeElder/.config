local opt = vim.opt

-- leader key
vim.g.mapleader = " "

-- disable netrw (use neo-tree instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- misc
opt.winborder = "rounded"
opt.relativenumber = true
opt.number = true
opt.wrap = false
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "no"
opt.laststatus = 3

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- turn off swapfile
opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true

-- disable mode / cmd in cmd bar
vim.opt.showmode = false
vim.opt.showcmd = false

-- auto reload files changed outside nvim
vim.opt.autoread = true
