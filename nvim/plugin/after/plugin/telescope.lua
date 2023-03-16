local builtin = require('telescope.builtin');
local telescope = require('telescope');

vim.keymap.set('n', '<CR>', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-n>', builtin.buffers, {})
vim.keymap.set('n', '<leader>gp', function()
  builtin.grep_string({ search = vim.fn.input('Grep > ') });
end)

telescope.setup({
  defaults = {
    file_ignore_patterns = {
      ".yarn"
    },
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = "delete_buffer",
        ["<esc>"] = "close"
      },
    },
  }
})
