return {
  "echasnovski/mini.surround",
  event = "VeryLazy",
  keys = {
    { "S", "gs", mode = "x", remap = true, desc = "Surround" },
    { "gss", "gs_", remap = true, desc = "Surround line" },
  },
  opts = {
    n_lines = 50,
    search_method = "cover_or_next",
    mappings = {
      add = "gs",
      delete = "ds",
      replace = "cs",
      find = "",
      find_left = "",
      highlight = "",
      update_n_lines = "",
    },
  },
}
