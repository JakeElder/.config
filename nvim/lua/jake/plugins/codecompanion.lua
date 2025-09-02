return {
	"olimorris/codecompanion.nvim",
	config = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"echasnovski/mini.diff",
	},
	init = function()
		require("mini.diff").setup({
			view = { style = "sign" },
		})

		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "deepseek",
					slash_commands = {
						["buffer"] = {
							callback = "strategies.chat.slash_commands.buffer",
							opts = { provider = "snacks" },
						},
						["help"] = {
							callback = "strategies.chat.slash_commands.help",
							opts = { provider = "snacks" },
						},
						["file"] = {
							callback = "strategies.chat.slash_commands.file",
							opts = {
								provider = "snacks",
								contains_code = true,
							},
						},
					},
				},
				inline = {
					adapter = "deepseek",
				},
				cmd = {
					adapter = "deepseek",
				},
			},
			display = {
				chat = {
					window = {
						width = 0.5,
					},
				},
				diff = {
					enabled = true,
					provider = "mini_diff",
					close_chat_at = 240,
					layout = "vertical",
				},
			},
		})

		-- Rest of your code remains the same
		vim.keymap.set({ "n", "v" }, "<leader>A", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
		vim.keymap.set(
			{ "n", "v" },
			"<leader><leader>",
			"<cmd>CodeCompanionChat Toggle<cr>",
			{ noremap = true, silent = true }
		)
		vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

		vim.cmd([[cab cc CodeCompanion]])
	end,
}
