return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		input = { enabled = true },
		picker = { ui_select = true },
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{
			"<C-c>",
			function()
				Snacks.bufdelete()
			end,
		},
		{
			"<CR>",
			function()
				Snacks.picker.smart()
			end,
			mode = { "n" },
		},

		{
			"gR",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history({
					layout = {
						layout = {
							box = "horizontal",
							width = 0.6,
							min_width = 120,
							height = 0.6,
							{
								box = "vertical",
								border = "rounded",
								title = "{title} {live} {flags}",
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
						},
					},
				})
			end,
			desc = "Command History",
		},
		{
			"<leader>.",
			function()
				Snacks.picker.files({ hidden = true })
			end,
			desc = "Find files (inc hidden) in cwd",
		},
		{
			"<leader>b",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Fuzzy find open buffers",
		},
		{
			"<C-p>",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find git files in cwd",
		},
		{
			"<leader>g",
			function()
				Snacks.picker.grep()
			end,
			desc = "Find string in cwd",
		},
		{
			"<leader>h",
			function()
				Snacks.picker.help({
					confirm = function(picker, item)
						picker:close()
						if item then
							vim.schedule(function()
								vim.cmd("vertical help " .. item.text)
							end)
						end
					end,
				})
			end,
			desc = "Find help",
		},
		{
			"<leader>k",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Find keymaps",
		},
		{
			"<leader>s",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "Find document symbols",
		},
		{
			"<leader>S",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "Find workspace symbols",
		},
		{
			"<leader>G",
			function()
				Snacks.lazygit()
			end,
			desc = "Find references",
		},
		{
			"<leader>*",
			function()
				Snacks.picker.lsp_references()
			end,
			desc = "Find references",
		},
	},
}
