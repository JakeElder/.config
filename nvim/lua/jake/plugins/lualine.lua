local mode = {
	"mode",
	fmt = function(s)
		local mode_map = {
			["NORMAL"] = "N",
			["O-PENDING"] = "N?",
			["INSERT"] = "I",
			["VISUAL"] = "V",
			["V-BLOCK"] = "VB",
			["V-LINE"] = "VL",
			["V-REPLACE"] = "VR",
			["REPLACE"] = "R",
			["COMMAND"] = "!",
			["SHELL"] = "SH",
			["TERMINAL"] = "T",
			["EX"] = "X",
			["S-BLOCK"] = "SB",
			["S-LINE"] = "SL",
			["SELECT"] = "S",
			["CONFIRM"] = "Y?",
			["MORE"] = "M",
		}
		return mode_map[s] or s
	end,
}

local function codecompanion_adapter_name()
	local chat = require("codecompanion").buf_get_chat(vim.api.nvim_get_current_buf())
	if not chat then
		return nil
	end

	return " " .. chat.adapter.formatted_name
end

local function codecompanion_current_model_name()
	local chat = require("codecompanion").buf_get_chat(vim.api.nvim_get_current_buf())
	if not chat then
		return nil
	end

	return chat.settings.model
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		local state = "idle"
		local state_icons = {
			idle = "󱚣",
			requesting = "󱚟",
			streaming = "󱚣",
		}

		local group = vim.api.nvim_create_augroup("CodeCompanionLualine", { clear = true })

		vim.api.nvim_create_autocmd({ "User" }, {
			pattern = "CodeCompanionRequestStarted",
			group = group,
			callback = function()
				state = "requesting"
				lualine.refresh()
			end,
		})
		vim.api.nvim_create_autocmd({ "User" }, {
			pattern = "CodeCompanionRequestFinished",
			group = group,
			callback = function()
				state = "idle"
				lualine.refresh()
			end,
		})

		vim.api.nvim_create_autocmd({ "User" }, {
			pattern = "CodeCompanionRequestStreaming",
			group = group,
			callback = function()
				state = "streaming"
				lualine.refresh()
			end,
		})

		local function colors()
			local is_catppuccin_active = vim.g.colors_name and string.find(vim.g.colors_name, "^catppuccin") ~= nil

			if is_catppuccin_active then
				local catppuccin_palettes = require("catppuccin.palettes")
				local theme_colors = catppuccin_palettes.get_palette("frappe")

				return {
					lazy_updates = theme_colors.blue,
					codecompanion = theme_colors.comment,
				}
			end

			return {
				lazy_updates = vim.fn.synIDattr(vim.fn.hlID("DiagnosticWarn"), "fg"),
				codecompanion = vim.fn.synIDattr(vim.fn.hlID("Comment"), "fg"),
			}
		end

		lualine.setup({
			options = {
				disabled_filetypes = {},
				section_separators = "",
				component_separators = "",
			},
			sections = {
				lualine_a = {
					{
						function()
							return "󰒍"
						end,
						cond = function()
							return os.getenv("HOST") == "relay"
						end,
					},
					{
						function()
							return ""
						end,
						cond = function()
							return os.getenv("HOST") == "pi"
						end,
					},
					mode,
				},
				lualine_b = { "diagnostics" },
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = function()
							local c = colors()
							return { fg = c.lazy_updates }
						end,
					},
					{ "filetype" },
				},
				lualine_y = {},
			},
			extensions = {
				"quickfix",
				{
					filetypes = { "codecompanion" },
					sections = {
						lualine_a = { mode },
						lualine_b = {},
						lualine_c = {},
						lualine_x = {
							{
								codecompanion_current_model_name,
								color = {
									fg = vim.fn.synIDattr(vim.fn.hlID("Comment"), "fg"),
								},
							},
						},
						lualine_y = {
							{
								codecompanion_adapter_name,
								color = {
									fg = vim.fn.synIDattr(vim.fn.hlID("Comment"), "fg"),
								},
							},
						},
						lualine_z = {
							{
								"robot",
								fmt = function()
									return state_icons[state] .. " "
								end,
							},
						},
					},
				},
			},
		})
	end,
}
