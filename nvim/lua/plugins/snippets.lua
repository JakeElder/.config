return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local rep = require("luasnip.extras").rep

    local function to_kebab_case(str)
      return str:gsub("(%u)", "-%1"):gsub("^-", ""):lower()
    end

    ls.config.set_config({
      store_selection_keys = "<Tab>",
    })

    local ts_snippets = {
      s("cd", {
        t("console.dir("),
        i(1),
        t(", { depth: null })"),
      }),
      s("cl", {
        t("console.log("),
        i(1),
        t(");"),
      }),
      s("i", {
        t("import {"),
        i(2),
        t("} from '"),
        i(1),
        t("';"),
      }),
      s("tc", {
        t({ "try {", "\t" }),
        f(function(_, snip)
          local sel = snip.env.LS_SELECT_DEDENT or {}
          return sel
        end, {}),
        i(1),
        t({ "", "} catch (e) {", "\t" }),
        i(2),
        t({ "", "}" }),
      }),
      s("rfb", {
        t("{ return ("),
        f(function(_, snip)
          local sel = snip.env.LS_SELECT_RAW or {}
          return sel
        end, {}),
        i(1),
        t("); }"),
      }),
    }

    ls.add_snippets("typescript", ts_snippets)
    ls.add_snippets("typescriptreact", ts_snippets)

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
  end,
}
