return {
	"ggandor/leap.nvim",
	dependencies = { "tpope/vim-repeat" },
	config = function()
		vim.keymap.set({ "n", "x" }, "<leader>l", "<Plug>(leap)")
		vim.keymap.set("n", "<leader>L", "<Plug>(leap-from-window)")
		vim.keymap.set("o", "l", "<Plug>(leap-forward)")
		vim.keymap.set("o", "L", "<Plug>(leap-backward)")
	end,
}
