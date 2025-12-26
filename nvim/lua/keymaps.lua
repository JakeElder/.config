local utils = require("utils")
local keymap = vim.keymap

-- window management
keymap.set("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>o", "<C-w>o", { desc = "Close other buffers" })
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Select pane to left" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Select pane to right" })
keymap.set("n", "<leader>q", ":quit<CR>", { desc = "Close window" })

-- increment/decrement numbers
keymap.set("n", "<leader>k", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>j", "<C-x>", { desc = "Decrement number" })

-- clear search highlights
keymap.set("n", "<esc>", utils.clear_search, { desc = "Clear search highlights and fallback", silent = true })

-- file path
keymap.set("n", "<leader>p", utils.show_path, { desc = "Show full file path" })
keymap.set("n", "<leader>P", utils.copy_path, { desc = "Copy full file path to clipboard" })

-- quickfix
keymap.set("n", "]q", utils.quickfix_next, { desc = "Next quickfix item", silent = true, noremap = true })
keymap.set("n", "[q", utils.quickfix_prev, { desc = "Previous quickfix item", silent = true, noremap = true })
keymap.set("n", "<leader>[", utils.quickfix_toggle, { desc = "Toggle quickfix" })

-- wrap
keymap.set("n", "<leader>w", ":set wrap!<CR>", { desc = "Toggle line wrap", silent = true })

-- hidden characters
keymap.set("n", "<leader>.", ":set list!<CR>", { desc = "Toggle hidden characters", silent = true })

-- select last paste
keymap.set("n", "gp", "`[v`]", { desc = "Select last paste" })

-- reload buffer
keymap.set("n", "<leader>e", "<cmd>e!<cr>", { desc = "Reload buffer" })
keymap.set("n", "<leader>E", utils.reload_all_buffers, { desc = "Reload all buffers" })

-- move lines in visual mode
keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down", silent = true })
keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up", silent = true })
