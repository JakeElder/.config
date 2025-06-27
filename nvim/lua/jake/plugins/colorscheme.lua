return {
  "catppuccin/nvim",
  lazy = false,
  config = function()
    local catppuccin = require("catppuccin")

    catppuccin.setup({
      -- transparent_background = true,
      custom_highlights = function(colors)
        return {
          -- Chrome
          MsgArea = { fg = colors.subtext1 },

          -- Flash
          FlashLabel = { fg = colors.yellow },

          -- Snacks
          SnacksInputTitle = { link = "Comment" },
          SnacksInputIcon = { fg = colors.yellow },
          SnacksInputBorder = { fg = colors.yellow },
          SnacksPicker = { bg = colors.base },
          SnacksPickerBorder = { bg = colors.base },
          SnacksPickerMatch = { fg = colors.green },
          SnacksPickerPrompt = { fg = colors.text },

          -- Neo Tree
          NeoTreeNormal = { link = "Normal" },
          NeoTreeNormalNC = { link = "Normal" },
          NeoTreeEndOfBuffer = { link = "EndOfBuffer" },
          NeoTreeRootName = { link = "Comment" },
          NeoTreeDirectoryIcon = { link = "Conceal" },
          NeoTreeExpander = { link = "Conceal" },
        }
      end,
      flavour = "frappe",
      color_overrides = {
        frappe = {
          rosewater = "#f2d5cf",
          flamingo = "#eebebe",
          pink = "#f4b8e4",
          mauve = "#ca9ee6",
          red = "#e78284",
          maroon = "#ea999c",
          peach = "#ef9f76",
          yellow = "#e5c890",
          green = "#a6d189",
          teal = "#81c8be",
          sky = "#99d1db",
          sapphire = "#85c1dc",
          blue = "#8caaee",
          lavender = "#babbf1",
          text = "#c6d0f5",
          subtext1 = "#b5bfe2",
          subtext0 = "#a5adce",
          overlay2 = "#949cbb",
          overlay1 = "#838ba7",
          overlay0 = "#737994",
          surface2 = "#626880",
          surface1 = "#51576d",
          surface0 = "#414559",
          base = "#303446",
          mantle = "#292c3c",
          crust = "#232634",
        },
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
