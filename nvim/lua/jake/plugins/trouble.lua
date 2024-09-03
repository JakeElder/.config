return {
	"folke/trouble.nvim",
	-- keys = {
	-- 	{
	-- 		"<leader>xx",
	-- 		"<cmd>Trouble diagnostics toggle<cr>",
	-- 		desc = "Diagnostics (Trouble)",
	-- 	},
	-- 	{
	-- 		"<leader>xX",
	-- 		"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	-- 		desc = "Buffer Diagnostics (Trouble)",
	-- 	},
	-- 	{
	-- 		"<leader>xs",
	-- 		"<cmd>Trouble symbols toggle focus=false<cr>",
	-- 		desc = "Symbols (Trouble)",
	-- 	},
	-- 	{
	-- 		"<leader>xl",
	-- 		"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	-- 		desc = "LSP Definitions / references / ... (Trouble)",
	-- 	},
	-- 	{
	-- 		"<leader>xL",
	-- 		"<cmd>Trouble loclist toggle<cr>",
	-- 		desc = "Location List (Trouble)",
	-- 	},
	-- 	{
	-- 		"<leader>xq",
	-- 		"<cmd>Trouble qflist toggle<cr>",
	-- 		desc = "Quickfix List (Trouble)",
	-- 	},
	-- },
	config = function()
		local keymap = vim.keymap
		local trouble = require("trouble")

		keymap.set("n", "<leader>x", function()
			if trouble.is_open({ mode = "diagnostics" }) then
				trouble.focus("diagnostics")
			else
				trouble.open("diagnostics")
			end
		end, { silent = true, desc = "Open Trouble diagnostics" })

		keymap.set("n", "<leader>X", function()
			trouble.close()
		end, { silent = true, desc = "Close Trouble diagnostics" })
	end,
}
