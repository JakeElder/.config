return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

		treesitter.setup({
			highlight = {
				enable = true,
			},
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"css",
				"dockerfile",
				"go",
				"gitignore",
				"graphql",
				"helm",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"prisma",
				"query",
				"sql",
				"svelte",
				"terraform",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader>n",
					node_incremental = "<leader>n",
					scope_incremental = false,
					node_decremental = "<leader>N",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["a?"] = "@conditional.outer",
						["i?"] = "@conditional.inner",
						["ia"] = "@assignment.inner",
						["aa"] = "@assignment.outer",
						-- ["ip"] = "@parameter.inner",
						-- ["ap"] = "@parameter.outer",
						["ic"] = "@call.inner",
						["ac"] = "@call.outer",
						["i/"] = "@comment.inner",
						["a/"] = "@comment.outer",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]a"] = "@assignment.rhs",
						["]p"] = "@parameter.inner",
						["]c"] = "@call.outer",
						["]?"] = "@conditional.outer",
						["]/"] = "@comment.outer",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[a"] = "@assignment.rhs",
						["[p"] = "@parameter.inner",
						["[c"] = "@call.outer",
						["[?"] = "@conditional.outer",
						["[/"] = "@comment.outer",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
					},
				},
			},
		})
	end,
}
