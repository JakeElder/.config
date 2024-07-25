return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		local mocha = require("catppuccin.palettes").get_palette("mocha")

		lualine.setup({
			sections = {
				lualine_a = {
					{
						function()
							return ""
						end,
						cond = function()
							return os.getenv("HOST") == "pi"
						end,
					},
					"mode",
				},
				lualine_b = { "diagnostics" },
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = mocha.peach },
					},
					{ "filetype" },
				},
			},
		})
	end,
}
