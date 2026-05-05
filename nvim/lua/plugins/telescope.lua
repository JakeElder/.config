return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "Telescope" },
  keys = {
    {
      "<CR>",
      function()
        if vim.bo.buftype ~= "" then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
        else
          vim.cmd("Telescope find_files")
        end
      end,
      desc = "Find files",
    },
    { "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>K", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>s", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
    { "<leader>S", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace symbols" },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command history" },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-u>"] = false,
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
          ["<M-u>"] = "preview_scrolling_up",
          ["<M-d>"] = "preview_scrolling_down",
        },
        n = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
          ["<C-u>"] = function(prompt_bufnr)
            local action_state = require("telescope.actions.state")
            local picker = action_state.get_current_picker(prompt_bufnr)
            for _ = 1, 10 do
              picker:move_selection(-1)
            end
          end,
          ["<C-d>"] = function(prompt_bufnr)
            local action_state = require("telescope.actions.state")
            local picker = action_state.get_current_picker(prompt_bufnr)
            for _ = 1, 10 do
              picker:move_selection(1)
            end
          end,
        },
      },
    },
    pickers = {
      find_files = {
        hidden = true,
        file_ignore_patterns = { "^.git/" },
      },
      live_grep = (function()
        local yank_path = function()
          local entry = require("telescope.actions.state").get_selected_entry()
          vim.fn.setreg("+", entry.filename)
          vim.notify("Copied: " .. entry.filename)
        end
        return {
          additional_args = { "--hidden", "--glob", "!.git/" },
          mappings = {
            i = { ["<C-y>"] = yank_path },
            n = { ["<C-y>"] = yank_path },
          },
        }
      end)(),
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
