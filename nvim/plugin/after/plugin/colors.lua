require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  color_overrides = {
    mocha = {
      text = "#FFFFFF",

      overlay0 = "#888888",
      surface1 = "#5F5F5F",
      surface0 = "#33333A",

      base = "#252529",
      mantle = "#212125",
      crust = "#11111E",
    }
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    telescope = true,
    notify = true,
    mini = false,
  },
})

vim.cmd.colorscheme('catppuccin')
