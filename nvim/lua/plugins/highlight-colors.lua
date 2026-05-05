return {
  "brenoprata10/nvim-highlight-colors",
  event = "VeryLazy",
  keys = {
    { "<leader>c", "<cmd>HighlightColors Toggle<cr>", desc = "Toggle color highlights" },
  },
  opts = {
    render = "virtual",
  },
  config = function(_, opts)
    require("nvim-highlight-colors").setup(opts)
    require("nvim-highlight-colors").turnOff()
  end,
}
