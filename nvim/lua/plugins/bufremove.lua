return {
  "echasnovski/mini.bufremove",
  keys = {
    {
      "<leader>x",
      function()
        require("mini.bufremove").delete()
      end,
      desc = "Close buffer",
    },
  },
}
