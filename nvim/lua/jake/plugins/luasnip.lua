return {
	"L3MON4D3/LuaSnip",
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local i = ls.insert_node
		local t = ls.text_node
		local f = ls.function_node
		local rep = require("luasnip.extras").rep

		local import_snippet = s("i", {
			t("import "),
			i(2),
			t(" from '"),
			i(1),
			t("';"),
		})

		-- Snippets
		ls.add_snippets("typescriptreact", { import_snippet })
		ls.add_snippets("typescript", { import_snippet })

		ls.add_snippets("typescriptreact", {
			s("cn", {
				t('className={css["'),
				i(1),
				t('"]}'),
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
					return args[1][1]:lower()
				end, { 1 }),
				t('"]}>{children}</div>'),
				t({ "", "};" }),
			}),
		})

		-- CSS Snippets
		local css_var_properties = {
			b = "border",
			ff = "font-family",
			ts = "text-shadow",
			bg = "background",
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
			create_css_var_snippet("b"),
			create_css_var_snippet("ff"),
			create_css_var_snippet("ts"),
			create_css_var_snippet("bg"),
		})

		-- Keymaps
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
