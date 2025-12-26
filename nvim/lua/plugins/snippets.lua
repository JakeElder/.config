return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    local ts_snippets = {
      s("cd", {
        t("console.dir("),
        i(1),
        t(", { depth: null })"),
      }),
    }

    ls.add_snippets("typescript", ts_snippets)
    ls.add_snippets("typescriptreact", ts_snippets)
  end,
}
