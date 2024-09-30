return {
	"folke/trouble.nvim",
	config = function()
		local keymap = vim.keymap
		local trouble = require("trouble")

		trouble.setup({ focus = true })

		keymap.set("n", "<leader>x", function()
			if trouble.is_open({ mode = "diagnostics" }) then
				trouble.focus("diagnostics")
			else
				trouble.focus({ mode = "diagnostics", focus = true })
			end
		end, { silent = true, desc = "Open Trouble diagnostics" })

		keymap.set("n", "<leader>X", function()
			trouble.close()
		end, { silent = true, desc = "Close Trouble diagnostics" })
	end,
}
