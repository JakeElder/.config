return {
	"L3MON4D3/LuaSnip",
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local i = ls.insert_node
		local t = ls.text_node

		-- Snippets
		ls.add_snippets("typescriptreact", {
			s("cn", {
				t('className={css["'),
				i(1),
				t('"]}'),
			}),
		})

		vim.keymap.set("i", "<Tab>", function()
			if ls.expand_or_locally_jumpable() then
				ls.expand_or_jump()
			else
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
			end
		end, { silent = true })

		vim.keymap.set("i", "<S-Tab>", function()
			if ls.expand_or_locally_jumpable() then
				ls.jump(-1)
			else
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", true)
			end
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<C-e>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { silent = true })
	end,
}
