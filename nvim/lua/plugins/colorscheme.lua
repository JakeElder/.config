return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      custom_highlights = function(colors)
        return {
          CursorLineNr = { fg = colors.subtext0 },
          LineNr = { fg = colors.overlay0 },
          CursorLine = { bg = colors.surface0 },
          DiagnosticUnderlineError = { undercurl = true, sp = colors.red },
          DiagnosticUnderlineWarn = { undercurl = true, sp = colors.yellow },
          DiagnosticUnderlineInfo = { undercurl = true, sp = colors.blue },
          DiagnosticUnderlineHint = { undercurl = true, sp = colors.teal },
          MsgArea = { fg = colors.subtext1 },
          Visual = { bg = colors.surface2 },
        }
      end,
      color_overrides = {
        mocha = {
          -- backgrounds (Ghostty base)
          base = "#282c34",
          mantle = "#24272e",
          crust = "#1d1f21",

          -- surfaces
          surface0 = "#2d3139",
          surface1 = "#353a44",
          surface2 = "#44495a",

          -- text
          text = "#ffffff",
          subtext1 = "#eaeaea",
          subtext0 = "#c4c8c6",

          -- overlay
          overlay2 = "#c4c8c6",
          overlay1 = "#999999",
          overlay0 = "#666666",

          -- accents (Ghostty palette)
          red = "#d54e53",
          maroon = "#cc6566",
          peach = "#f0c674",
          yellow = "#e7c547",
          green = "#b6bd68",
          teal = "#70c0b1",
          sky = "#8abeb7",
          sapphire = "#7aa6da",
          blue = "#82a2be",
          lavender = "#c397d8",
          mauve = "#b294bb",
          pink = "#cc6666",
          flamingo = "#cc6666",
          rosewater = "#eaeaea",
        },
      },
    })

    vim.cmd("colorscheme catppuccin")

    vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
      callback = function()
        vim.opt_local.cursorline = true
      end,
    })
    vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
      callback = function()
        vim.opt_local.cursorline = false
      end,
    })
  end,
}
