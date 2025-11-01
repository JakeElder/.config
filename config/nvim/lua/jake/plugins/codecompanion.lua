vim.g.codecompanion_yolo_mode = true

return {
	"olimorris/codecompanion.nvim",
	config = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"echasnovski/mini.diff",
	},
	init = function()
		local diff = require("mini.diff")
		diff.setup({
			source = diff.gen_source.none(),
		})

		require("codecompanion").setup({
			adapters = {
				http = {
					deepseek = function()
						return require("codecompanion.adapters").extend("deepseek", {
							schema = {
								model = {
									default = "deepseek-chat",
								},
							},
						})
					end,
					zai = function()
						return require("codecompanion.adapters").extend("openai_compatible", {
							formatted_name = "Z.AI Coding Plan",
							env = {
								url = "https://api.z.ai/api/coding/paas/v4",
								api_key = vim.env.ZHIPU_API_KEY,
								chat_url = "/chat/completions",
							},
							schema = {
								model = {
									default = "glm-4.6",
								},
							},
						})
					end,
					openrouter = function()
						return require("codecompanion.adapters").extend("openai_compatible", {
							formatted_name = "OpenRouter",
							env = {
								url = "https://openrouter.ai/api",
								api_key = vim.env.OPENROUTER_API_KEY,
								chat_url = "/v1/chat/completions",
							},
							schema = {
								model = {
									default = "qwen/qwen3-coder-30b-a3b-instruct",
								},
							},
						})
					end,
				},
			},
			strategies = {
				chat = {
					adapter = "zai",
				},
				inline = {
					adapter = "zai",
				},
				cmd = {
					adapter = "zai",
				},
			},
			display = {
				chat = {
					window = {
						width = 0.5,
					},
				},
				diff = {
					enabled = false,
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
