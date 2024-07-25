local keymap = vim.keymap

-- set leader
vim.g.mapleader = " "

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window management
keymap.set("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>q", ":quit<CR>", { desc = "Close window" })
keymap.set("n", "<leader>w", ":write<CR>", { desc = "Save buffer" })
keymap.set("n", "<M-h>", ":bprev<CR>", { desc = "Previous buffer" })
keymap.set("n", "<M-l>", ":bnext<CR>", { desc = "Next buffer" })

-- clear search highlights
keymap.set("n", "<esc>", ":nohl<CR>", { desc = "Clear search highlights", silent = true })
