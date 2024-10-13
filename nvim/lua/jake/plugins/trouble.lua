return {
	"folke/trouble.nvim",
	opts = {
		warn_no_results = false,
		open_no_results = true,
		win = {
			position = "right",
			size = 50,
		},
	},
	cmd = "Trouble",
	keys = {
		{
			"<leader>x",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},
}
