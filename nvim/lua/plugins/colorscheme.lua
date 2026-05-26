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
          WinSeparator = { fg = colors.mantle },
          MsgArea = { fg = colors.subtext1 },
          Visual = { bg = colors.surface2 },
          ["@string.special.url"] = { underline = false },
          ["@string.special.url.tsx"] = { underline = false },
        }
      end,
      -- Palette comes from tc via env vars set in ~/.config/tc/.tc,
      -- sourced by zsh on shell startup. Restart nvim to pick up changes.
      color_overrides = {
        mocha = {
          base      = vim.env.TC_BASE,
          mantle    = vim.env.TC_MANTLE,
          crust     = vim.env.TC_CRUST,
          surface0  = vim.env.TC_SURFACE0,
          surface1  = vim.env.TC_SURFACE1,
          surface2  = vim.env.TC_SURFACE2,
          overlay0  = vim.env.TC_OVERLAY0,
          overlay1  = vim.env.TC_OVERLAY1,
          overlay2  = vim.env.TC_OVERLAY2,
          subtext0  = vim.env.TC_SUBTEXT0,
          subtext1  = vim.env.TC_SUBTEXT1,
          text      = vim.env.TC_TEXT,
          rosewater = vim.env.TC_ROSEWATER,
          flamingo  = vim.env.TC_FLAMINGO,
          pink      = vim.env.TC_PINK,
          mauve     = vim.env.TC_MAUVE,
          red       = vim.env.TC_RED,
          maroon    = vim.env.TC_MAROON,
          peach     = vim.env.TC_PEACH,
          yellow    = vim.env.TC_YELLOW,
          green     = vim.env.TC_GREEN,
          teal      = vim.env.TC_TEAL,
          sky       = vim.env.TC_SKY,
          sapphire  = vim.env.TC_SAPPHIRE,
          blue      = vim.env.TC_BLUE,
          lavender  = vim.env.TC_LAVENDER,
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
