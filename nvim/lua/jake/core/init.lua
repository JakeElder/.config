require("jake.core.options")
require("jake.core.keymaps")

-- Only show cursor line on active window
vim.cmd([[
  augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
  augroup END
]])

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("HelmFiletype", { clear = true }),
	pattern = {
		"*/templates/*.yaml",
		"*/templates/*.yml",
		"*/templates/*.tpl",
		"*.gotmpl",
		"Chart.yaml",
		"helmfile*.yaml",
	},
	callback = function()
		vim.opt_local.filetype = "helm"
	end,
})
