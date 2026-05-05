return {
  "echasnovski/mini.bufremove",
  keys = function()
    local del = function()
      require("mini.bufremove").delete()
    end
    return {
      { "<leader>x", del, desc = "Close buffer" },
      { "<C-c>", del, desc = "Close buffer" },
    }
  end,
}
