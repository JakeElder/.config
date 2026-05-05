return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    { "<leader>Q", "<cmd>AutoSession save<cr><cmd>qa<cr>", desc = "Save session and quit" },
    { "<leader>R", "<cmd>AutoSession restore<cr>", desc = "Restore session" },
    { "<leader>*", "<cmd>AutoSession save<cr><cmd>cq 100<cr>", desc = "Restart with session" },
  },
  opts = {
    auto_restore = false,
    auto_save = false,
  },
}
