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
				frappe = {
					-- rosewater = "#f2d5cf",
					-- flamingo = "#eebebe",
					-- pink = "#f4b8e4",
					-- mauve = "#ca9ee6",
					-- red = "#e78284",
					-- maroon = "#ea999c",
					-- peach = "#ef9f76",
					-- yellow = "#e5c890",
					-- green = "#a6d189",
					-- teal = "#81c8be",
					-- sky = "#99d1db",
					-- sapphire = "#85c1dc",
					-- blue = "#8caaee",
					-- lavender = "#babbf1",
					-- text = "#c6d0f5",
					-- subtext1 = "#b5bfe2",
					-- subtext0 = "#a5adce",
					-- overlay2 = "#949cbb",
					-- overlay1 = "#838ba7",
					-- overlay0 = "#737994",
					-- surface2 = "#626880",
					-- surface1 = "#51576d",
					-- surface0 = "#414559",
					-- base = "#303446",
					-- mantle = "#292c3c",
					-- crust = "#232634",
				},
				mocha = {
					-- rosewater = "#f5e0dc",
					-- flamingo = "#f2cdcd",
					-- pink = "#f5c2e7",
					-- mauve = "#cba6f7",
					-- red = "#f38ba8",
					-- maroon = "#eba0ac",
					-- peach = "#fab387",
					-- yellow = "#f9e2af",
					-- green = "#a6e3a1",
					-- teal = "#94e2d5",
					-- sky = "#89dceb",
					-- sapphire = "#74c7ec",
					-- blue = "#89b4fa",
					-- lavender = "#b4befe",
					-- text = "#eeeeee",
					-- subtext1 = "#bac2de",
					-- subtext0 = "#a6adc8",
					-- overlay2 = "#9399b2",
					-- overlay1 = "#7f849c",
					-- overlay0 = "#6c7086",
					-- surface2 = "#585b70",
					-- surface1 = "#45475a",
					-- surface0 = "#313244",
					-- base = "#212121",
					-- mantle = "#1c1c1c",
					-- crust = "#191919",
				},
			},
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
