return {
	"chrisgrieser/nvim-various-textobjs",
	config = function()
		require("various-textobjs").setup({
			keymaps = {
				useDefaults = false,
			},
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

		-- Indentation text objects
		vim.keymap.set({ "o", "x" }, "ii", '<cmd>lua require("various-textobjs").indentation("inner", "inner")<CR>')
		vim.keymap.set({ "o", "x" }, "ai", '<cmd>lua require("various-textobjs").indentation("outer", "outer")<CR>')

		-- Value text objects (between = and ,)
		vim.keymap.set({ "o", "x" }, "iv", '<cmd>lua require("various-textobjs").value("inner")<CR>')
		vim.keymap.set({ "o", "x" }, "av", '<cmd>lua require("various-textobjs").value("outer")<CR>')

		-- Number text objects
		vim.keymap.set({ "o", "x" }, "in", '<cmd>lua require("various-textobjs").number("inner")<CR>')
		vim.keymap.set({ "o", "x" }, "an", '<cmd>lua require("various-textobjs").number("outer")<CR>')

		-- Key text objects (for key-value pairs)
		vim.keymap.set({ "o", "x" }, "ik", '<cmd>lua require("various-textobjs").key("inner")<CR>')
		vim.keymap.set({ "o", "x" }, "ak", '<cmd>lua require("various-textobjs").key("outer")<CR>')

		-- Rest of indent (from cursor to end of indentation)
		vim.keymap.set({ "o", "x" }, "ir", '<cmd>lua require("various-textobjs").restOfIndentation()<CR>')

		-- Subword text objects (for camelCase/snake_case parts)
		vim.keymap.set({ "o", "x" }, "iS", '<cmd>lua require("various-textobjs").subword("inner")<CR>')
		vim.keymap.set({ "o", "x" }, "aS", '<cmd>lua require("various-textobjs").subword("outer")<CR>')

		-- Line text objects (without indentation)
		vim.keymap.set({ "o", "x" }, "il", '<cmd>lua require("various-textobjs").lineCharacterwise("inner")<CR>')
		vim.keymap.set({ "o", "x" }, "al", '<cmd>lua require("various-textobjs").lineCharacterwise("outer")<CR>')

		-- URL/URI text objects
		vim.keymap.set({ "o", "x" }, "iu", '<cmd>lua require("various-textobjs").url()<CR>')

		-- Function arguments/parameters
		vim.keymap.set({ "o", "x" }, "ia", '<cmd>lua require("various-textobjs").parameter("inner")<CR>')
		vim.keymap.set({ "o", "x" }, "aa", '<cmd>lua require("various-textobjs").parameter("outer")<CR>')

		-- Last change text objects
		vim.keymap.set({ "o", "x" }, "i.", '<cmd>lua require("various-textobjs").lastChange()<CR>')
	end,
}
