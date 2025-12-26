return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ lsp_fallback = true })
      end,
      desc = "Format",
    },
    {
      "<leader>F",
      function()
        vim.b.format_on_save_disabled = not vim.b.format_on_save_disabled
        vim.notify("Format on save: " .. (vim.b.format_on_save_disabled and "OFF" or "ON"))
      end,
      desc = "Toggle format on save",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      terraform = { "terraform_fmt" },
      zsh = { "shfmt" },
      sh = { "shfmt" },
    },
    format_on_save = function()
      if vim.b.format_on_save_disabled then
        return nil
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
  },
}
