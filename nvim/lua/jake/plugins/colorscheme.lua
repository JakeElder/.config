return {
	"catppuccin/nvim",
	lazy = false,
	config = function()
		local catpuccin = require("catppuccin")

		catpuccin.setup({
			custom_highlights = function(colors)
				return {
					-- Snacks
					SnacksInputTitle = { fg = colors.peach },
					SnacksInputIcon = { fg = colors.peach },
					SnacksInputBorder = { fg = colors.peach },
					SnacksPicker = { bg = colors.base },

					-- Neo Tree
					NeoTreeNormal = { link = "Normal" },
					NeoTreeNormalNC = { link = "Normal" },
					NeoTreeEndOfBuffer = { link = "EndOfBuffer" },
					NeoTreeRootName = { link = "Comment" },
					NeoTreeDirectoryIcon = { link = "Conceal" },
					NeoTreeExpander = { link = "Conceal" },
				}
			end,
			flavour = "frappe",
			color_overrides = {
				-- Gemini contrast
				-- frappe = {
				-- 	rosewater = "#f4d8d2",
				-- 	flamingo = "#f0c1c1",
				-- 	pink = "#f6bbe7",
				-- 	mauve = "#cda1e9",
				-- 	red = "#ea8487",
				-- 	maroon = "#ec9c9f",
				-- 	peach = "#f1a37a",
				-- 	yellow = "#e8cc94",
				-- 	green = "#a9d58c",
				-- 	teal = "#84ccc2",
				-- 	sky = "#9cd4df",
				-- 	sapphire = "#88c4e0",
				-- 	blue = "#90aef0",
				-- 	lavender = "#bdbef4",
				-- 	text = "#ced6f9",
				-- 	subtext1 = "#bec6e6",
				-- 	subtext0 = "#aab3d3",
				-- 	overlay2 = "#98a0bf",
				-- 	overlay1 = "#878ea9",
				-- 	overlay0 = "#777d97",
				-- 	surface2 = "#666b84",
				-- 	surface1 = "#555a71",
				-- 	surface0 = "#44485f",
				-- 	base = "#2d3040",
				-- 	mantle = "#262939",
				-- 	crust = "#202331",
				-- },
				-- Default
				-- frappe = {
				-- 	rosewater = "#f2d5cf",
				-- 	flamingo = "#eebebe",
				-- 	pink = "#f4b8e4",
				-- 	mauve = "#ca9ee6",
				-- 	red = "#e78284",
				-- 	maroon = "#ea999c",
				-- 	peach = "#ef9f76",
				-- 	yellow = "#e5c890",
				-- 	green = "#a6d189",
				-- 	teal = "#81c8be",
				-- 	sky = "#99d1db",
				-- 	sapphire = "#85c1dc",
				-- 	blue = "#8caaee",
				-- 	lavender = "#babbf1",
				-- 	text = "#c6d0f5",
				-- 	subtext1 = "#b5bfe2",
				-- 	subtext0 = "#a5adce",
				-- 	overlay2 = "#949cbb",
				-- 	overlay1 = "#838ba7",
				-- 	overlay0 = "#737994",
				-- 	surface2 = "#626880",
				-- 	surface1 = "#51576d",
				-- 	surface0 = "#414559",
				-- 	base = "#303446",
				-- 	mantle = "#292c3c",
				-- 	crust = "#232634",
				-- },
			},
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
