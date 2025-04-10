vim.g.user_emmet_install_global = 0
vim.g.user_emmet_mode = "i"

return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = { "mattn/emmet-vim" },
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "html", "css", "scss", "sass", "less" },
			callback = function()
				vim.cmd("EmmetInstall")
			end,
		})
	end,
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		sources = {
			default = { "lsp", "path", "snippets" },
			providers = {
				snippets = { score_offset = 2 },
				lsp = { score_offset = 1 },
			},
		},
		snippets = { preset = "luasnip" },
		completion = {
			keyword = { range = "full" },
			menu = {
				auto_show = false,
			},
		},
		signature = {
			enabled = false,
		},
		keymap = {
			preset = "default",
			["<Esc>"] = {
				"cancel",
				"fallback",
			},
			["<C-n>"] = {
				function(cmp)
					if cmp.is_menu_visible() then
						return cmp.select_next()
					else
						return cmp.show()
					end
				end,
				"fallback_to_mappings",
			},
			["<C-y>"] = {
				function(cmp)
					if cmp.is_menu_visible() then
						return cmp.select_and_accept()
					else
						cmp.show_and_insert()
						cmp.accept()
					end
				end,
				"fallback",
			},
			["<Tab>"] = {
				function(cmp)
					if
						vim.tbl_contains({ "css", "scss", "sass", "less" }, vim.bo.filetype)
						and vim.fn["emmet#isExpandable"]() == 1
					then
						vim.api.nvim_feedkeys(
							vim.api.nvim_replace_termcodes("<Plug>(emmet-expand-abbr)", true, true, true),
							"",
							true
						)
						return true
					end

					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_and_accept()
					end
				end,
				"snippet_forward",
				"fallback",
			},
		},
		cmdline = {
			enabled = true,
		},
	},
}
