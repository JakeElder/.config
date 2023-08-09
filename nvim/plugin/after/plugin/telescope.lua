local builtin = require('telescope.builtin');
local telescope = require('telescope');

vim.keymap.set('n', '<CR>', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-n>', builtin.buffers, {})
vim.keymap.set('n', '<leader>gg', builtin.live_grep, {})
vim.keymap.set('n', 'gr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>go', builtin.vim_options, {})
vim.keymap.set('n', '<leader>gk', builtin.keymaps, {})
vim.keymap.set('n', '<leader>:', builtin.command_history, {})

-- telescope.load_extension('lsp_handlers')

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
