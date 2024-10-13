return {
	"dmmulroy/tsc.nvim",
	config = function()
		require("tsc").setup({
			auto_open_qflist = false,
			auto_close_qflist = false,
			auto_focus_qflist = true,
			use_trouble_qflist = true,
			enable_progress_notifications = false,
			enable_error_notifications = true,
			run_as_monorepo = false,
			flags = { noEmit = true, watch = true },
		})

		vim.keymap.set("n", "<leader>z", ":TSC<CR>", { silent = true, desc = "Run TypeScript type checking" })
		vim.keymap.set("n", "<leader>Z", ":TSCStop<CR>", { silent = true, desc = "Run TypeScript type checking" })
	end,
}
