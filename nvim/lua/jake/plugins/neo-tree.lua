return {
	-- If you want neo-tree's file operations to work with LSP (updating imports, etc.), you can use a plugin like
	-- https://github.com/antosha417/nvim-lsp-file-operations:
	-- {
	--   "antosha417/nvim-lsp-file-operations",
	--   dependencies = {
	--     "nvim-lua/plenary.nvim",
	--     "nvim-neo-tree/neo-tree.nvim",
	--   },
	--   config = function()
	--     require("lsp-file-operations").setup()
	--   end,
	-- },
	-- {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	lazy = false,
	config = function()
		require("neo-tree").setup({
			popup_border_style = "rounded",
			enable_git_status = false,
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false,
				},
			},
			default_component_configs = {
				indent = {
					with_markers = false,
				},
				icon = {
					enabled = true,
					default = "",
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					folder_empty_open = "",
					provider = function() end,
				},
				last_modified = {
					format = "relative",
					enabled = false,
				},
				file_size = {
					enabled = false,
				},
			},
			window = {
				mappings = {
					["/"] = "noop",
					["<esc>"] = function()
						if vim.v.hlsearch == 1 then
							vim.cmd("nohlsearch")
						else
							vim.cmd("Neotree close")
						end
					end,
					["W"] = function(state)
						local node = state.tree:get_node()
						local top_node = node
						local last_parent = nil

						while top_node:get_parent_id() do
							last_parent = top_node
							top_node = state.tree:get_node(top_node:get_parent_id())
						end

						local focus_id = last_parent and last_parent:get_id() or top_node:get_id()

						require("neo-tree.sources.filesystem.commands").close_all_nodes(state)
						require("neo-tree.ui.renderer").focus_node(state, focus_id)
					end,
					["P"] = function(state)
						local node = state.tree:get_node()
						local parent_id = node:get_parent_id()
						if parent_id then
							require("neo-tree.ui.renderer").focus_node(state, parent_id)
						end
					end,
				},
			},
			event_handlers = {
				{
					event = "neo_tree_buffer_enter",
					handler = function()
						vim.opt_local.relativenumber = true
					end,
				},
			},
		})

		vim.api.nvim_set_hl(0, "NeoTreeNormal", { link = "Normal" })
		vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { link = "Normal" })
		vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { link = "EndOfBuffer" })

		-- vim.api.nvim_set_hl(0, "NeoTreeRootName", { link = "Comment" })
		vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { link = "Conceal" })
		vim.api.nvim_set_hl(0, "NeoTreeExpander", { link = "Conceal" })

		vim.keymap.set("n", "-", "<Cmd>Neotree reveal position=current<CR>")
	end,
}
