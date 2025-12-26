return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local colors = require("catppuccin.palettes").get_palette("mocha")
    require("lualine").setup({
      options = {
        icons_enabled = true,
        section_separators = "",
        component_separators = "",
        theme = {
          normal = {
            c = { fg = colors.overlay2, bg = "NONE" },
          },
          inactive = {
            c = { fg = colors.overlay0, bg = "NONE" },
          },
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = colors.peach },
          },
          "location",
          { "filetype", colored = false },
        },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
