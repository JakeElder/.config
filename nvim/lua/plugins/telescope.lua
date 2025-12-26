return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<CR>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>K", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>s", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
    { "<leader>S", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace symbols" },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-u>"] = false,
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
    pickers = {
      find_files = {
        hidden = true,
        file_ignore_patterns = { "^.git/" },
      },
      live_grep = {
        additional_args = { "--hidden", "--glob", "!.git/" },
      },
      buffers = {
        mappings = {
          i = {
            ["<C-d>"] = "delete_buffer",
          },
        },
      },
    },
  },
}
