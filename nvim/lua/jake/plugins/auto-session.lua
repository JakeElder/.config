return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/", "~/Dev", "~/Downloads", "~/Documents", "~/Desktop" },
		})

		local keymap = vim.keymap

		-- keymap.set("n", "<leader>s", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
		keymap.set("n", "<leader>Q", function()
			vim.cmd("SessionSave")
			vim.cmd("qall")
		end, { desc = "Save session for auto session root dir" })
		keymap.set("n", "<leader>R", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
	end,
}
