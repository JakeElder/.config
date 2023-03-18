require("luasnip.loaders.from_vscode").lazy_load({
  paths = { "./snippets" }
})

local luasnip = require('luasnip')

vim.keymap.set('i', '<Tab>', function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    local key = vim.api.nvim_replace_termcodes('<Tab>', true, true, true)
    vim.api.nvim_feedkeys(key, 'tn', false)
  end
end)

vim.keymap.set('i', '<S-Tab>', function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    local key = vim.api.nvim_replace_termcodes('<C-d>', true, true, true)
    vim.api.nvim_feedkeys(key, 'tn', false)
  end
end)
