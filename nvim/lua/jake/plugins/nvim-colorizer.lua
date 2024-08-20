return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({})
		vim.keymap.set("n", "<leader>c", "<cmd>ColorizerToggle<CR>", { desc = "Toggle colorizer" })
	end,
}
