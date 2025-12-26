return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "json",
        "yaml",
        "markdown",
        "bash",
        "helm",
        "gotmpl",
        "terraform",
        "hcl",
      },
      highlight = { enable = true },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["av"] = { query = "@assignment.outer", desc = "Assignment" },
            ["iv"] = { query = "@assignment.rhs", desc = "Assignment value" },
            ["ik"] = { query = "@assignment.lhs", desc = "Assignment key" },
          },
        },
      },
    })
  end,
}
