local keymap = vim.keymap

-- set leader
vim.g.mapleader = " "

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window management
keymap.set("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>o", "<C-w>o", { desc = "Close other buffers" })
keymap.set("n", "<leader>q", ":quit<CR>", { desc = "Close window" })
keymap.set("n", "<leader>w", ":write<CR>", { desc = "Save buffer" })
keymap.set("n", "<leader>W", ":wall<CR>", { desc = "Save all buffers" })
keymap.set("n", "<leader>e", ":edit<CR>", { desc = "Reload buffer from disk" })
keymap.set("n", "<leader>E", ":edit!<CR>", { desc = "Reload buffer from disk" })
keymap.set("n", "<M-h>", ":bprev<CR>", { desc = "Previous buffer" })
keymap.set("n", "<M-l>", ":bnext<CR>", { desc = "Next buffer" })

-- clear search highlights
keymap.set("n", "<esc>", ":nohl<CR>", { desc = "Clear search highlights", silent = true })
keymap.set("n", "<leader>n", ":nohl<CR>", { desc = "Clear search highlights", silent = true })

-- display full file path
keymap.set("n", "<leader>p", ":echo expand('%:p')<CR>", { desc = "Show full file path" })

-- Inspect
keymap.set({ "n", "v" }, "<leader>I", "<cmd>InspectTree<cr>")

-- quickfix
keymap.set("n", "]]", function()
	vim.cmd("silent! cnext")
end, { desc = "Next quickfix item", silent = true, noremap = true })

keymap.set("n", "[[", function()
	vim.cmd("silent! cprev")
end, { desc = "Previous quickfix item", silent = true, noremap = true })
