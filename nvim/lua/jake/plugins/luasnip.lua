return {
	"L3MON4D3/LuaSnip",
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

		local function_snippet = s("af", {
			t("const "),
			i(1),
			t(" = ("),
			i(2),
			t(") => {"),
			t({ "", "\t" }),
			i(3),
			t({ "", "};" }),
		})

		local async_function_snippet = s("aaf", {
			t("const "),
			i(1),
			t(" = async ("),
			i(2),
			t(") => {"),
			t({ "", "\t" }),
			i(3),
			t({ "", "};" }),
		})

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

		local if_statement_snippet = s("if", {
			t("if ("),
			i(1),
			t({ ") {", "\t" }),
			i(2),
			t({ "", "}" }),
		})

		local use_state_snippet = s("us", {
			t("const ["),
			i(1),
			t(", set"),
			f(function(args)
				local name = args[1][1] or ""
				return name:sub(1, 1):upper() .. name:sub(2)
			end, { 1 }),
			t("] = useState<"),
			i(3, "any"),
			t(">("),
			i(2),
			t(");"),
		})

		-- Snippets
		ls.add_snippets("typescriptreact", {
			import_snippet,
			export_snippet,
			console_log_snippet,
			console_dir_snippet,
			if_statement_snippet,
			function_snippet,
			async_function_snippet,
			use_state_snippet,
		})
		ls.add_snippets("typescript", {
			import_snippet,
			export_snippet,
			console_log_snippet,
			console_dir_snippet,
			if_statement_snippet,
			function_snippet,
			async_function_snippet,
		})
		ls.add_snippets("javascript", {
			console_log_snippet,
			console_dir_snippet,
			if_statement_snippet,
			function_snippet,
			async_function_snippet,
		})

		ls.add_snippets("typescriptreact", {
			s("cn", {
				t('className={css["'),
				i(0),
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
				i(1, "Component"),
				t({ "", " */", "" }),
				t({ "", "type " }),
				rep(1),
				t({ "Props = {};", "" }),
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
				i(1, "Component"),
				t({ "", " */", "" }),
				t({ "", "type " }),
				rep(1),
				t({ "Props = {", "\tchildren: React.ReactNode;", "};", "" }),
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
				t('"]}>{children}</div>;'),
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
	end,
}
