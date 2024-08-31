return {
	"chrisgrieser/nvim-various-textobjs",
	config = function()
		require("various-textobjs").setup({
			useDefaultKeymaps = true,
			disabledKeymaps = { "gG" },
		})

		-- Delete surrounding indentation
		vim.keymap.set("n", "dsi", function()
			-- select outer indentation
			require("various-textobjs").indentation("outer", "outer")

			-- plugin only switches to visual mode when a textobj has been found
			local indentationFound = vim.fn.mode():find("V")
			if not indentationFound then
				return
			end

			-- dedent indentation
			vim.cmd.normal({ "<", bang = true })

			-- delete surrounding lines
			local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1]
			local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1]
			vim.cmd(tostring(endBorderLn) .. " delete") -- delete end first so line index is not shifted
			vim.cmd(tostring(startBorderLn) .. " delete")
		end, { desc = "Delete Surrounding Indentation" })

		-- Entire buffer motion
		vim.keymap.set({ "o", "x" }, "ae", '<cmd>lua require("various-textobjs").entireBuffer()<CR>')
	end,
}
