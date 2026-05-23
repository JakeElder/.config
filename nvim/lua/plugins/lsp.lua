return {
  {
    "folke/snacks.nvim",
    event = "VeryLazy",
    opts = {
      input = { enabled = true },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  },
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "stylua", "prettier", "shfmt" },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "ts_ls",
        "lua_ls",
        "emmet_ls",
        "html",
        "cssls",
        "jsonls",
        "yamlls",
        "bashls",
        "helm_ls",
        "terraformls",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim", "saghen/blink.cmp" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      vim.lsp.config("*", { capabilities = capabilities })
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { disable = { "missing-fields" } },
          },
        },
      })
      vim.lsp.config("helm_ls", {
        settings = {
          ["helm-ls"] = {
            yamlls = { enabled = false },
          },
        },
      })
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("emmet_ls")
      vim.lsp.enable("html")
      vim.lsp.enable("cssls")
      vim.lsp.enable("jsonls")
      vim.lsp.enable("yamlls")
      vim.lsp.enable("bashls")
      vim.lsp.enable("helm_ls")
      vim.lsp.enable("terraformls")
      vim.keymap.set("n", "<C-j>", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end)
      vim.keymap.set("n", "<C-k>", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end)
      vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
      vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Code action" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<cr>", { desc = "Go to references" })
      vim.keymap.set("n", "<leader>d", function()
        local diag = vim.diagnostic.get_next({ cursor_position = vim.api.nvim_win_get_cursor(0) })
        if diag then
          vim.fn.setreg("+", diag.message)
          vim.notify("Copied: " .. diag.message)
        end
      end, { desc = "Copy diagnostic to clipboard" })
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}
