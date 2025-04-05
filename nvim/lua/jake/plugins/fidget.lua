return {
	"j-hui/fidget.nvim",
	init = function()
		require("fidget").setup({})
		require("plugins.codecompanion.fidget"):init()
	end,
}
