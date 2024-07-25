return {
  "catppuccin/nvim",
  name = "catpuccin",
  priority = 1000,
  config = function()
    local catpuccin = require("catppuccin")

    catpuccin.setup({
      flavour = "mocha"
    })

    vim.cmd.colorscheme "catppuccin"
  end
}
