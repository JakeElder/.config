return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = { "L3MON4D3/LuaSnip" },
  event = "InsertEnter",
  opts = {
    keymap = {
      preset = "default",
      ["<C-n>"] = { "show", "select_next", "fallback" },
      ["<C-y>"] = { "select_and_accept", "show", "select_next" },
      ["<Esc>"] = { "cancel", "fallback" },
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<M-j>"] = { "scroll_documentation_down", "fallback" },
      ["<M-k>"] = { "scroll_documentation_up", "fallback" },
      ["<C-e>"] = {
        function(cmp)
          if cmp.is_menu_visible() then
            return cmp.select_and_accept()
          else
            cmp.show()
            vim.schedule(function()
              cmp.select_and_accept()
            end)
            return true
          end
        end,
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        path = {
          opts = { show_hidden_files_by_default = true },
        },
      },
    },
    snippets = { preset = "luasnip" },
    completion = {
      menu = {
        auto_show = false,
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind" },
            { "source_name" },
          },
        },
      },
      list = { selection = { preselect = true, auto_insert = true } },
    },
  },
}
