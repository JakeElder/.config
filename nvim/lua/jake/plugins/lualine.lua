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

		local mocha = require("catppuccin.palettes").get_palette("mocha")

		lualine.setup({
			options = {
				disabled_filetypes = {},
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
						color = { fg = mocha.peach },
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
						ualine_c = {},
						lualine_x = { codecompanion_current_model_name },
						lualine_y = { codecompanion_adapter_name },
						lualine_z = { "location" },
					},
				},
			},
		})
	end,
}
