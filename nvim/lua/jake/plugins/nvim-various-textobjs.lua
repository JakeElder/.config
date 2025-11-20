return {
	"chrisgrieser/nvim-various-textobjs",
	config = function()
		require("various-textobjs").setup({
			keymaps = { useDefaults = false },
		})

		local function map(...)
			vim.keymap.set(...)
		end

		map("n", "dsi", function()
			require("various-textobjs").indentation("outer", "outer")

			local indentationFound = vim.fn.mode():find("V")
			if not indentationFound then
				return
			end

			vim.cmd.normal({ "<", bang = true })

			local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1]
			local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1]
			vim.cmd(tostring(endBorderLn) .. " delete")
			vim.cmd(tostring(startBorderLn) .. " delete")
		end, { desc = "Delete Surrounding Indentation" })

		-- Entire buffer motion
		map({ "o", "x" }, "ae", '<cmd>lua require("various-textobjs").entireBuffer()<CR>')

		-- Indentation text objects
		map({ "o", "x" }, "ii", '<cmd>lua require("various-textobjs").indentation("inner", "inner")<CR>')
		map({ "o", "x" }, "ai", '<cmd>lua require("various-textobjs").indentation("outer", "outer")<CR>')

		-- Value text objects (between = and ,)
		map({ "o", "x" }, "iv", '<cmd>lua require("various-textobjs").value("inner")<CR>')
		map({ "o", "x" }, "av", '<cmd>lua require("various-textobjs").value("outer")<CR>')

		-- Key text objects (for key-value pairs)
		map({ "o", "x" }, "ik", '<cmd>lua require("various-textobjs").key("inner")<CR>')
		map({ "o", "x" }, "ak", '<cmd>lua require("various-textobjs").key("outer")<CR>')

		-- Number text objects
		map({ "o", "x" }, "in", '<cmd>lua require("various-textobjs").number("inner")<CR>')
		map({ "o", "x" }, "an", '<cmd>lua require("various-textobjs").number("outer")<CR>')

		-- Rest of indent (from cursor to end of indentation)
		map({ "o", "x" }, "ir", '<cmd>lua require("various-textobjs").restOfIndentation()<CR>')

		-- Subword text objects (for camelCase/snake_case parts)
		map({ "o", "x" }, "iS", '<cmd>lua require("various-textobjs").subword("inner")<CR>')
		map({ "o", "x" }, "aS", '<cmd>lua require("various-textobjs").subword("outer")<CR>')

		-- Line text objects (without indentation)
		map({ "o", "x" }, "il", '<cmd>lua require("various-textobjs").lineCharacterwise("inner")<CR>')
		map({ "o", "x" }, "al", '<cmd>lua require("various-textobjs").lineCharacterwise("outer")<CR>')

		-- URL/URI text objects
		map({ "o", "x" }, "iu", '<cmd>lua require("various-textobjs").url()<CR>')

		-- Function arguments/parameters
		map({ "o", "x" }, "i,", '<cmd>lua require("various-textobjs").argument("inner")<CR>')
		map({ "o", "x" }, "a,", '<cmd>lua require("various-textobjs").argument("outer")<CR>')

		-- HTML attribute
		map({ "o", "x" }, "ix", '<cmd>lua require("various-textobjs").htmlAttribute("inner")<CR>')
		map({ "o", "x" }, "ax", '<cmd>lua require("various-textobjs").htmlAttribute("outer")<CR>')

		-- Pipe
		map({ "o", "x" }, "iP", '<cmd>lua require("various-textobjs").shellPipe("inner")<CR>')
		map({ "o", "x" }, "aP", '<cmd>lua require("various-textobjs").shellPipe("outer")<CR>')

		-- Any quote
		map({ "o", "x" }, "iq", '<cmd>lua require("various-textobjs").anyQuote("inner")<CR>')
		map({ "o", "x" }, "aq", '<cmd>lua require("various-textobjs").anyQuote("outer")<CR>')

		-- Chain member
		map({ "o", "x" }, "im", '<cmd>lua require("various-textobjs").chainMember("inner")<CR>')
		map({ "o", "x" }, "am", '<cmd>lua require("various-textobjs").chainMember("outer")<CR>')

		-- File path
		map({ "o", "x" }, "iF", '<cmd>lua require("various-textobjs").filepath("inner")<CR>')
		map({ "o", "x" }, "aF", '<cmd>lua require("various-textobjs").filepath("outer")<CR>')

		-- Next closing bracket
		map({ "o", "x" }, "C", '<cmd>lua require("various-textobjs").toNextClosingBracket()<CR>')

		-- Next quotation mark
		map({ "o", "x" }, "Q", '<cmd>lua require("various-textobjs").toNextQuotationMark()<CR>')

		-- Emoji
		map({ "o", "x" }, ".", '<cmd>lua require("various-textobjs").emoji()<CR>')

		-- Paragraph linewise
		map({ "o", "x" }, "p", '<cmd>lua require("various-textobjs").restOfParagraph()<CR>')
	end,
}
