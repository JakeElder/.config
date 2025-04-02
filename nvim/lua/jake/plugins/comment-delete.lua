-- Comment deletion plugin that uses treesitter to identify and remove comments
-- Uses operator pattern for motion support (e.g., dc{motion})

return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {},
	config = function()
		-- Custom operator for deleting comments
		function _G.delete_comments_operator()
			local old_func = vim.go.operatorfunc
			_G.delete_comments_opfunc = function()
				local start_pos = vim.api.nvim_buf_get_mark(0, "[")
				local end_pos = vim.api.nvim_buf_get_mark(0, "]")
				local start_row, start_col = start_pos[1] - 1, start_pos[2]
				local end_row, end_col = end_pos[1] - 1, end_pos[2]

				remove_comments_in_range(start_row, start_col, end_row, end_col)

				vim.go.operatorfunc = old_func
				_G.delete_comments_opfunc = nil
			end
			vim.go.operatorfunc = "v:lua.delete_comments_opfunc"
			return "g@"
		end

		-- Function to remove comments in a specific range
		function remove_comments_in_range(start_row, start_col, end_row, end_col)
			local ok, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
			if not ok then
				vim.notify("Treesitter utils not available", vim.log.levels.ERROR)
				return
			end

			local bufnr = vim.api.nvim_get_current_buf()
			local ft = vim.bo.filetype

			-- Get root node
			local root = ts_utils.get_root_for_position(start_row, start_col, bufnr)
			if not root then
				vim.notify("Could not get treesitter root node", vim.log.levels.WARN)
				return
			end

			-- Parse query for comments
			local query_ok, query = pcall(vim.treesitter.query.parse, ft, "(comment) @comment")
			if not query_ok then
				vim.notify("Could not parse treesitter query for " .. ft, vim.log.levels.WARN)
				return
			end

			-- Collect nodes to remove (to avoid modifying during iteration)
			local nodes_to_remove = {}

			-- Find comment nodes in the range
			for id, node in query:iter_captures(root, bufnr, start_row, end_row + 1) do
				local srow, scol, erow, ecol = node:range()

				-- Check if node is in range
				if srow >= start_row and erow <= end_row then
					table.insert(nodes_to_remove, { srow = srow, scol = scol, erow = erow, ecol = ecol })
				end
			end

			if #nodes_to_remove == 0 then
				vim.notify("No comments found in the specified range", vim.log.levels.INFO)
				return
			end

			-- Remove comments (in reverse order to avoid position shifts)
			table.sort(nodes_to_remove, function(a, b)
				return a.srow > b.srow or (a.srow == b.srow and a.scol > b.scol)
			end)

			vim.api.nvim_exec("normal! m`", false) -- Set mark for jumplist

			for _, node_info in ipairs(nodes_to_remove) do
				local lines = vim.api.nvim_buf_get_lines(bufnr, node_info.srow, node_info.erow + 1, false)

				if #lines == 1 then
					-- Single-line comment
					local line = lines[1]
					local prefix = line:sub(1, node_info.scol)
					local suffix = line:sub(node_info.ecol + 1)
					vim.api.nvim_buf_set_lines(bufnr, node_info.srow, node_info.srow + 1, false, { prefix .. suffix })
				else
					-- Multi-line comment
					local first_line = lines[1]:sub(1, node_info.scol)
					local last_line = lines[#lines]:sub(node_info.ecol + 1)
					vim.api.nvim_buf_set_lines(
						bufnr,
						node_info.srow,
						node_info.erow + 1,
						false,
						{ first_line .. last_line }
					)
				end
			end

			vim.notify("Removed " .. #nodes_to_remove .. " comment(s)", vim.log.levels.INFO)
		end

		-- Set up keymappings
		vim.api.nvim_set_keymap("n", "dc", "v:lua.delete_comments_operator()", { expr = true, noremap = true })
		vim.api.nvim_set_keymap("x", "dc", "v:lua.delete_comments_operator()", { expr = true, noremap = true })

		-- Makes dcc work on the current line
		vim.api.nvim_set_keymap("n", "dcc", "dcl", { noremap = true })
	end,
}

