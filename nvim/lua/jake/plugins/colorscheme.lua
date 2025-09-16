return {
	"rose-pine/neovim",
	dependencies = { "catppuccin/nvim" },
	lazy = false,
	priority = 1000,
	config = function()
		package.path = package.path .. ";" .. vim.fn.expand("~") .. "/Code/ttyc/generated/?.lua"

		local function run()
			package.loaded["ttyc.colors"] = nil
			local ok, colors = pcall(require, "ttyc.colors")

			if not ok then
				return
			end

			if colors.dialect == "rose-pine" then
				local rose_pine = require("rose-pine")
				rose_pine.setup({
					variant = "main",
					palette = { main = colors.palette },
				})

				vim.defer_fn(function()
					vim.cmd.colorscheme("rose-pine")
				end, 0)

				return
			end

			if colors.dialect == "catppuccin" then
				local catppuccin = require("catppuccin")
				catppuccin.setup({
					flavor = "mocha",
					color_overrides = {
						all = colors.palette,
					},
					custom_highlights = function(p)
						return {
							-- Chrome
							MsgArea = { fg = p.subtext1 },

							-- Flash
							FlashLabel = { fg = p.yellow },

							-- Snacks
							SnacksInputTitle = { link = "Comment" },
							SnacksInputIcon = { fg = p.yellow },
							SnacksInputBorder = { fg = p.yellow },
							SnacksPicker = { bg = p.base },
							SnacksPickerBorder = { bg = p.base },
							SnacksPickerMatch = { fg = p.green },
							SnacksPickerPrompt = { fg = p.text },

							-- Neo Tree
							NeoTreeNormal = { link = "Normal" },
							NeoTreeNormalNC = { link = "Normal" },
							NeoTreeEndOfBuffer = { link = "EndOfBuffer" },
							NeoTreeRootName = { link = "Comment" },
							NeoTreeDirectoryIcon = { link = "Conceal" },
							NeoTreeExpander = { link = "Conceal" },
						}
					end,
				})

				vim.defer_fn(function()
					vim.cmd.colorscheme("catppuccin")
				end, 0)

				return
			end
		end

		local signal_group = vim.api.nvim_create_augroup("SignalHandlerTTYC", { clear = true })
		vim.api.nvim_create_autocmd("Signal", {
			group = signal_group,
			pattern = "SIGUSR1",
			callback = run,
		})

		run()
	end,
}
