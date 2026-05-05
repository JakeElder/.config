local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } },
  change_detection = { notify = false },
  checker = { enabled = true, notify = false, frequency = 90 },
})

vim.keymap.set("n", "<leader>i", "<cmd>Lazy<cr>", { desc = "Lazy" })
vim.keymap.set("n", "<leader>U", "<cmd>Lazy update<cr>", { desc = "Lazy update" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lazy",
  callback = function()
    vim.keymap.set("n", "<Esc>", function()
      vim.api.nvim_win_close(0, false)
    end, { buffer = true, nowait = true })
  end,
})
