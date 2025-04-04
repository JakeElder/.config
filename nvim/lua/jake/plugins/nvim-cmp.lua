return {
	enabled = false,
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		cmp.setup({
			completion = {
				autocomplete = false,
				completeopt = "menu,menuone,preview",
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-j>"] = cmp.mapping.scroll_docs(-4),
				["<C-k>"] = cmp.mapping.scroll_docs(4),
				["<Esc>"] = cmp.mapping.abort(),
			}),
			sources = cmp.config.sources({
				{ name = "path" },
				{
					name = "nvim_lsp",
					-- entry_filter = function(entry)
					-- 	return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
					-- end,
				},
				{ name = "luasnip" },
				{ name = "buffer" },
			}),

			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 80,
					ellipsis_char = "...",
				}),
			},
		})
	end,
}
