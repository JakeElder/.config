return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"BurntSushi/ripgrep",
		"davvid/telescope-git-grep.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local open_with_trouble = require("trouble.sources.telescope").open

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				layout_config = {
					horizontal = {
						prompt_position = "top",
					},
				},
				sorting_strategy = "ascending",
				mappings = {
					i = {
						["<C-d>"] = actions.delete_buffer + actions.move_to_top,
						["<Esc>"] = actions.close,
						["<C-u>"] = false,
						["<C-k>"] = actions.move_selection_previous,
						["<C-e>"] = { "<esc>", type = "command" },
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-t>"] = open_with_trouble,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		local keymap = vim.keymap
		local builtin = require("telescope.builtin")

		keymap.set("n", "<CR>", builtin.find_files, { desc = "Find files in cwd" })
		keymap.set("n", "<leader>.", function()
			builtin.find_files({ hidden = true })
		end, { desc = "Find files (inc hidden) in cwd" })
		keymap.set("n", "<leader>b", builtin.buffers, { desc = "Fuzzy find open buffers" })
		keymap.set("n", "<C-p>", builtin.git_files, { desc = "Find git files in cwd" })
		keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Find string in cwd" })
		keymap.set("n", "<leader>t", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		keymap.set("n", "<leader>k", builtin.keymaps, { desc = "Find keymaps" })
		keymap.set("n", "<leader>s", builtin.lsp_document_symbols, { desc = "Find document symbols" })
		keymap.set("n", "<leader>S", builtin.lsp_workspace_symbols, { desc = "Find workspace symbols" })
		keymap.set("n", "<leader>*", builtin.lsp_references, { desc = "Find workspace symbols" })
		vim.keymap.set("n", "<leader>G", function()
			require("git_grep").live_grep()
		end)
	end,
}
