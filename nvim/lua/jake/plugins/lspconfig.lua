return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"b0o/schemastore.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		local capabilities = vim.lsp.protocol.make_client_capabilities()

		local bind_lsp_keys = function(_, buffer)
			local keymap = vim.keymap
			local buf = vim.lsp.buf

			local opts = function(unique_opts)
				return vim.tbl_extend("force", { buffer = buffer, silent = true }, unique_opts)
			end

			keymap.set("n", "gd", buf.definition, opts({ desc = "Go to definition" }))
			keymap.set({ "n", "v" }, "<leader>a", buf.code_action, opts({ desc = "See available code actions" }))
			keymap.set("n", "<space>r", buf.rename, opts({ desc = "Smart rename" }))
			keymap.set("n", "K", buf.hover, opts({ desc = "Show documentation for what is under cursor" }))
			keymap.set("n", "<leader>|", ":LspRestart<CR>", opts({ desc = "Restart LSP" }))

			keymap.set("n", "<C-k>", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end, opts({ desc = "Go to previous diagnostic" }))

			keymap.set("n", "<C-j>", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end, opts({ desc = "Go to next diagnostic" }))
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = bind_lsp_keys,
		})

		vim.diagnostic.config({
			virtual_text = false,
		})

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
				"pylint",
				"shfmt",
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"bashls",
				"cssls",
				"gopls",
				"graphql",
				"html",
				"jsonls",
				"lua_ls",
				"pyright",
				"taplo",
				"terraformls",
				"ts_ls",
			},
			automatic_enable = true,
		})

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		vim.lsp.config("bashls", {
			capabilities = capabilities,
			filetypes = { "sh", "bash", "zsh" },
		})

		vim.lsp.config("jsonls", {
			capabilities = capabilities,
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})

		vim.lsp.config("graphql", {
			capabilities = capabilities,
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})
	end,
}
