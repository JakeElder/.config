return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		input = { enabled = true },
		picker = {
			ui_select = true,
			win = {
				input = {
					keys = {
						["<c-u>"] = { "<C-u>", mode = "i", expr = true, desc = "Clear Input Line" },
					},
				},
			},
		},
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
				if vim.bo.filetype == "qf" then
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
					return
				end

				Snacks.picker.smart({
					multi = {
						"buffers",
						{ source = "recent", filter = { cwd = true } },
						{ source = "files", filter = { cwd = true } },
					},
					actions = {
						copy_file_content = function(picker, item)
							item = item or picker:current({ resolve = false })
							if not item or not item.file then
								Snacks.notify("No file selected or item has no file path.", vim.log.levels.WARN)
								return
							end

							local target_bufnr = vim.api.nvim_win_get_buf(picker.main)
							if not vim.api.nvim_buf_is_valid(target_bufnr) then
								Snacks.notify("Original buffer is no longer valid.", vim.log.levels.ERROR)
								return
							end

							local lines = vim.fn.readfile(item.file)
							if vim.v.shell_error ~= 0 then
								Snacks.notify("Error reading file: " .. item.file, vim.log.levels.ERROR)
								return
							end

							-- Get cursor position in the original window/buffer
							local cursor_pos = vim.api.nvim_win_get_cursor(picker.main)

							-- Insert lines at the cursor position
							vim.api.nvim_buf_set_lines(target_bufnr, cursor_pos[1] - 1, cursor_pos[1] - 1, false, lines)
							Snacks.notify("Copied content from " .. vim.fn.fnamemodify(item.file, ":t"))
							picker:close()
						end,
					},
					win = {
						input = {
							keys = {
								["<c-y>"] = {
									"copy_file_content",
									mode = { "n", "i" },
									desc = "Copy File Content to Original Buffer",
								},
							},
						},
					},
				})
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
			"<leader>b",
			function()
				Snacks.picker.buffers({
					win = {
						list = {
							keys = {
								["<c-x>"] = { "bufdelete", desc = "Delete Buffer" },
							},
						},
					},
				})
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
				Snacks.picker.lsp_symbols({
					filter = {
						default = {
							"Class",
							"Constructor",
							"Enum",
							"Field",
							"Function",
							"Interface",
							"Method",
							"Module",
							"Namespace",
							"Property",
							"Struct",
							"Trait",
							"Constant",
						},
					},
				})
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
			desc = "Snacks Lazygit",
		},
		{
			"<leader>*",
			function()
				Snacks.picker.lsp_references()
			end,
			desc = "Find references",
		},
		{
			"<leader>d",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>q",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Diagnostics",
		},
	},
}
