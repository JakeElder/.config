local opt = vim.opt

-- misc
opt.relativenumber = true
opt.number = true
opt.wrap = false
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "no"
opt.laststatus = 3
opt.conceallevel = 2

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false
vim.opt.undodir = os.getenv("XDG_CACHE_HOME") .. "/nvim/undodir"
vim.opt.undofile = true
