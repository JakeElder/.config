return {
  "kwkarlwang/bufjump.nvim",
  keys = {
    {
      "<C-h>",
      function()
        require("bufjump").backward()
      end,
      desc = "Previous buffer",
    },
    {
      "<C-l>",
      function()
        require("bufjump").forward()
      end,
      desc = "Next buffer",
    },
  },
}
