return {
	"olimorris/codecompanion.nvim",
	config = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"echasnovski/mini.diff",
		"j-hui/fidget.nvim",
	},
	init = function()
		require("plugins.codecompanion.fidget"):init()

		require("mini.diff").setup({
			view = { style = "sign" },
		})

		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "anthropic",
					slash_commands = {
						["file"] = {
							callback = "strategies.chat.slash_commands.file",
							description = "Select a file using Telescope",
							opts = {
								provider = "snacks",
								contains_code = true,
							},
						},
					},
				},
				inline = {
					adapter = "anthropic",
				},
				cmd = {
					adapter = "anthropic",
				},
			},
			display = {
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
