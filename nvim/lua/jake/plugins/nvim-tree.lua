return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")
		local api = require("nvim-tree.api")

		local previous_bufnr = nil

		local function open_tree()
			previous_bufnr = vim.api.nvim_get_current_buf()
			api.tree.open({ current_window = true, find_file = true })
		end

		local function cancel()
			if previous_bufnr and vim.api.nvim_buf_is_valid(previous_bufnr) then
				require("nvim-tree.view").abandon_current_window()
				vim.api.nvim_set_current_buf(previous_bufnr)
			end
		end

		local function on_attach(bufnr)
			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			api.config.mappings.default_on_attach(bufnr)
			vim.keymap.set("n", "<CR>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
			vim.keymap.set("n", "<ESC>", cancel, opts("Close: Cancel"))
			vim.keymap.set("n", "<C-c>", cancel, opts("Close: Cancel"))
		end

		nvimtree.setup({
			on_attach = on_attach,
			view = {
				number = true,
				relativenumber = true,
			},
			renderer = {
				icons = {
					show = {
						file = false,
						folder = false,
					},
					glyphs = {
						git = {
							untracked = "",
						},
					},
				},
			},
		})

		vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "NONE" })
		vim.keymap.set("n", "-", open_tree, { desc = "Open File Explorer" })
	end,
}
