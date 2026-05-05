return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "-", "<cmd>Neotree current reveal<cr>", desc = "File explorer" },
  },
  opts = {
    use_popups_for_input = false,
    clipboard = {
      sync = "universal",
    },
    event_handlers = {
      {
        event = "file_open_requested",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
      {
        event = "neo_tree_buffer_enter",
        handler = function()
          vim.opt_local.number = true
          vim.opt_local.relativenumber = true
        end,
      },
    },
    filesystem = {
      hijack_netrw_behavior = "open_current",
      filtered_items = {
        visible = true,
      },
    },
    default_component_configs = {
      git_status = { symbols = false },
    },
    window = {
      mappings = {
        ["<esc>"] = "close_window",
        ["/"] = "none",
        ["P"] = function(state)
          local node = state.tree:get_node()
          local parent_id = node:get_parent_id()
          if parent_id then
            require("neo-tree.ui.renderer").focus_node(state, parent_id)
          end
        end,
        ["W"] = function(state)
          local node = state.tree:get_node()
          local last_parent = nil
          while node:get_parent_id() do
            last_parent = node
            node = state.tree:get_node(node:get_parent_id())
          end
          require("neo-tree.sources.filesystem.commands").close_all_nodes(state)
          require("neo-tree.ui.renderer").focus_node(state, last_parent and last_parent:get_id() or node:get_id())
        end,
        ["Y"] = function(state)
          local node = state.tree:get_node()
          vim.fn.setreg("+", node.path)
          vim.notify("Copied: " .. node.path)
        end,
      },
    },
  },
}
