return {
	"MeanderingProgrammer/render-markdown.nvim",
	opts = {
		file_types = { "markdown", "codecompanion" },
	},
	ft = { "markdown", "codecompanion" },
	keys = {
		{
			"<leader>M",
			function()
				require("render-markdown").buf_toggle()
			end,
			desc = "Toggle markdown rendering",
		},
	},
}
