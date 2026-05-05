local utils = require("utils")
local keymap = vim.keymap

-- window management
keymap.set("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", '<leader>"', "<C-w>s", { desc = "Split window vertically" })
keymap.set("n", "<leader>o", "<C-w>o", { desc = "Close other buffers" })
keymap.set("n", "<M-h>", function()
  utils.tmux_navigate("h")
end, { desc = "Navigate left" })
keymap.set("n", "<M-j>", function()
  utils.tmux_navigate("j")
end, { desc = "Navigate down" })
keymap.set("n", "<M-k>", function()
  utils.tmux_navigate("k")
end, { desc = "Navigate up" })
keymap.set("n", "<M-l>", function()
  utils.tmux_navigate("l")
end, { desc = "Navigate right" })
keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Close window", silent = true })

-- increment/decrement numbers
keymap.set("n", "<leader>k", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>j", "<C-x>", { desc = "Decrement number" })

-- clear search highlights
keymap.set("n", "<esc>", utils.escape, { desc = "Close floats / clear search / clear status", silent = true })

-- file path
keymap.set("n", "<leader>p", utils.show_path, { desc = "Show full file path" })
keymap.set("n", "<leader>P", utils.copy_path, { desc = "Copy full file path to clipboard" })

-- alternate buffer
keymap.set("n", "<C-space>", "<cmd>e #<cr>", { desc = "Alternate buffer" })

-- quickfix
keymap.set("n", ")", utils.quickfix_next, { desc = "Next quickfix item", silent = true })
keymap.set("n", "(", utils.quickfix_prev, { desc = "Previous quickfix item", silent = true })
keymap.set("n", "<leader>[", "<cmd>botright copen<cr>", { desc = "Open quickfix" })
keymap.set("n", "<leader>]", "<cmd>cclose<cr>", { desc = "Close quickfix" })
keymap.set("n", "<leader>0", "<cmd>call setqflist([])<cr>", { desc = "Clear quickfix" })

-- write
keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Write file" })

-- wrap
keymap.set("n", "<leader>W", utils.toggle_wrap, { desc = "Toggle line wrap" })

-- hidden characters
keymap.set("n", "<leader>.", utils.toggle_list, { desc = "Toggle hidden characters" })

-- select last paste
keymap.set("n", "gp", "`[v`]", { desc = "Select last paste" })

-- reload buffer
keymap.set("n", "<leader>e", "<cmd>e!<cr>", { desc = "Reload buffer" })
keymap.set("n", "<leader>E", utils.reload_all_buffers, { desc = "Reload all buffers" })

-- move lines in visual mode
keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down", silent = true })
keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up", silent = true })

-- treesitter
keymap.set("n", "<leader>T", "<cmd>InspectTree<cr>", { desc = "Inspect syntax tree" })
keymap.set("n", "<leader>I", "<cmd>Inspect<cr>", { desc = "Inspect" })
