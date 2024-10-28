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
keymap.set("n", "<leader>W", ":wall<CR>", { desc = "Save all buffers" })
keymap.set("n", "<M-h>", ":bprev<CR>", { desc = "Previous buffer" })
keymap.set("n", "<M-l>", ":bnext<CR>", { desc = "Next buffer" })

-- clear search highlights
keymap.set("n", "<esc>", ":nohl<CR>", { desc = "Clear search highlights", silent = true })
keymap.set("n", "<leader>n", ":nohl<CR>", { desc = "Clear search highlights", silent = true })

-- quickfix
function NavigateQuickfixFile(direction)
	local current_file = vim.fn.bufname("%")
	local qf_list = vim.fn.getqflist()
	local current_idx = vim.fn.getqflist({ idx = 0 }).idx

	if direction == "next" then
		for i = current_idx + 1, #qf_list do
			if qf_list[i].bufnr ~= vim.fn.bufnr(current_file) then
				vim.cmd("silent! cc " .. i)
				return
			end
		end
	elseif direction == "prev" then
		for i = current_idx - 1, 1, -1 do
			if qf_list[i].bufnr ~= vim.fn.bufnr(current_file) then
				vim.cmd("silent! cc " .. i)
				return
			end
		end
	end
end

-- vim.keymap.set("n", "]}", function()
-- 	NavigateQuickfixFile("next")
-- end, { noremap = true, silent = true, desc = "Next file in quickfix list" })
--
-- vim.keymap.set("n", "[{", function()
-- 	NavigateQuickfixFile("prev")
-- end, { noremap = true, silent = true, desc = "Previous file in quickfix list" })

keymap.set({ "n", "v" }, "<leader>d", "<c-x>", { desc = "Decrement" })
keymap.set({ "n", "v" }, "<leader>i", "<c-a>", { desc = "Increment" })

keymap.set("n", "]]", function()
	vim.cmd("silent! cnext")
end, { desc = "Next quickfix item", silent = true, noremap = true })

keymap.set("n", "[[", function()
	vim.cmd("silent! cprev")
end, { desc = "Previous quickfix item", silent = true, noremap = true })
