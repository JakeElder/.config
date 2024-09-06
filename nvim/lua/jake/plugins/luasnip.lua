return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"mattn/emmet-vim",
	},
	init = function()
		vim.g.user_emmet_install_global = 0
		vim.g.user_emmet_leader_key = "<C-q>"

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "css",
			callback = function()
				vim.cmd("EmmetInstall")
			end,
		})
	end,
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local i = ls.insert_node
		local t = ls.text_node
		local f = ls.function_node
		local rep = require("luasnip.extras").rep

		local function to_kebab_case(str)
			return str:gsub("(%l)(%u)", "%1-%2"):gsub("(%u)(%u%l)", "%1-%2"):lower()
		end

		local import_snippet = s("i", {
			t("import "),
			i(2),
			t(" from '"),
			i(1),
			t("';"),
		})

		local export_snippet = s("e", {
			t("export "),
			i(2),
			t(" from '"),
			i(1),
			t("';"),
		})

		local console_log_snippet = s("cl", {
			t("console.log("),
			i(1),
			t(");"),
		})

		local console_dir_snippet = s("cd", {
			t("console.dir("),
			i(1),
			t(", { depth: null, colors: true });"),
		})

		-- Snippets
		ls.add_snippets("typescriptreact", { import_snippet, export_snippet, console_log_snippet, console_dir_snippet })
		ls.add_snippets("typescript", { import_snippet, export_snippet, console_log_snippet, console_dir_snippet })
		ls.add_snippets("javascript", { console_log_snippet, console_dir_snippet })

		ls.add_snippets("typescriptreact", {
			s("cn", {
				t('className={css["'),
				i(1),
				t('"]}'),
			}),
		})

		ls.add_snippets("typescriptreact", {
			s("c", {
				t("children: React.ReactNode;"),
			}),
		})

		ls.add_snippets("typescriptreact", {
			s("rc", {
				t({ "/*", " * " }),
				i(1),
				t({ "", " */", "" }),
				t({ "", "interface " }),
				rep(1),
				t({ "Props {}", "" }),
				t({ "", "export const " }),
				rep(1),
				t(" = (props: "),
				rep(1),
				t("Props) => {"),
				t({ "", "\treturn " }),
				i(2, "<></>"),
				t({ ";", "};" }),
			}),
		})

		ls.add_snippets("typescriptreact", {
			s("rcc", {
				t({ "/*", " * " }),
				i(1),
				t({ "", " */", "" }),
				t({ "", "interface " }),
				rep(1),
				t({ "Props {", "\tchildren: React.ReactNode", "}", "" }),
				t({ "", "export const " }),
				rep(1),
				t(" = ({ children }: "),
				rep(1),
				t("Props) => {"),
				t({ "", "\treturn " }),
				t('<div className={css["'),
				f(function(args)
					return to_kebab_case(args[1][1])
				end, { 1 }),
				t('"]}>{children}</div>'),
				t({ "", "};" }),
			}),
		})

		-- CSS Snippets
		local css_var_properties = {
			c = "color",
			b = "border",
			ff = "font-family",
			ts = "text-shadow",
			bg = "background",
			br = "border-radius",
		}

		-- function to generate the snippet
		local function create_css_var_snippet(trigger_prefix)
			return s({ trig = trigger_prefix .. "(%d+)", regTrig = true }, {
				f(function(_, snip)
					local property = css_var_properties[trigger_prefix]
					if not property then
						return ""
					end

					-- Get the character after the cursor
					local cursor_pos = vim.api.nvim_win_get_cursor(0)
					local line = vim.api.nvim_get_current_line()
					local after_cursor = line:sub(cursor_pos[2] + 1, cursor_pos[2] + 1)

					-- Determine if a semicolon is needed
					local semicolon = after_cursor == ";" and "" or ";"

					return "var(--" .. property .. "-" .. snip.captures[1] .. ")" .. semicolon
				end, {}),
			})
		end

		-- Add CSS snippets
		ls.add_snippets("css", {
			create_css_var_snippet("c"),
			create_css_var_snippet("b"),
			create_css_var_snippet("ff"),
			create_css_var_snippet("ts"),
			create_css_var_snippet("bg"),
			create_css_var_snippet("br"),
		})

		-- Keymaps
		vim.keymap.set("i", "<Tab>", function()
			if ls.expand_or_locally_jumpable() then
				ls.expand_or_jump()
			elseif vim.bo.filetype == "css" and vim.fn["emmet#isExpandable"]() == 1 then
				vim.api.nvim_feedkeys(
					vim.api.nvim_replace_termcodes("<Plug>(emmet-expand-abbr)", true, true, true),
					"",
					true
				)
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
