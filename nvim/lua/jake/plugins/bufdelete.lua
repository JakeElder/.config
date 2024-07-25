return {
	"famiu/bufdelete.nvim",
	config = function()
		local function close()
			require("bufdelete").bufdelete(0)
		end
		vim.keymap.set("n", "<C-c>", close, { desc = "Close current buffer" })
	end,
}
