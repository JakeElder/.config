local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true
})

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'rust_analyzer',
  'lua_ls'
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

lsp.setup_nvim_cmp({
  completion = { autocomplete = false },
  mapping = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping({
      i = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          return
        end
        cmp.complete()
      end,
    }),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = vim.NIL,
    ['<S-Tab>'] = vim.NIL
  }),
  formatting = {
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
        nvim_lua = 'Π',
      }
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
})

lsp.set_preferences({
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  local buf_path = vim.api.nvim_buf_get_name(bufnr)
  local has_format_support = client.supports_method("textDocument/formatting")
  local is_snippet = string.find(buf_path, '/snippets/')

  if (has_format_support and not is_snippet) then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      group = vim.api.nvim_create_augroup("Format",
        { clear = true }
      ),
      callback = function() vim.lsp.buf.format() end
    })
  end

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "gtd", function() vim.lsp.buf.type_definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  -- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<C-j>", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<C-k>", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
  vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action({}) end, opts)
  -- vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.nvim_workspace()
lsp.setup()
