return {
  "chrisgrieser/nvim-various-textobjs",
  opts = {
    lookForwardSmall = 30,
    lookForwardBig = 30,
  },
  keys = {
    {
      "ae",
      '<cmd>lua require("various-textobjs").entireBuffer()<CR>',
      mode = { "o", "x" },
      desc = "Entire buffer",
    },
    {
      "as",
      '<cmd>lua require("various-textobjs").subword("outer")<CR>',
      mode = { "o", "x" },
      desc = "Subword",
    },
    {
      "is",
      '<cmd>lua require("various-textobjs").subword("inner")<CR>',
      mode = { "o", "x" },
      desc = "Subword",
    },
    {
      "am",
      '<cmd>lua require("various-textobjs").chainMember("outer")<CR>',
      mode = { "o", "x" },
      desc = "Chain member",
    },
    {
      "im",
      '<cmd>lua require("various-textobjs").chainMember("inner")<CR>',
      mode = { "o", "x" },
      desc = "Chain member",
    },
    {
      "a>",
      '<cmd>lua require("various-textobjs").indentation("outer", "outer")<CR>',
      mode = { "o", "x" },
      desc = "Indentation",
    },
    {
      "ii",
      '<cmd>lua require("various-textobjs").indentation("inner", "inner")<CR>',
      mode = { "o", "x" },
      desc = "Indentation",
    },
    {
      "aq",
      '<cmd>lua require("various-textobjs").anyQuote("outer")<CR>',
      mode = { "o", "x" },
      desc = "Any quote",
    },
    {
      "iq",
      '<cmd>lua require("various-textobjs").anyQuote("inner")<CR>',
      mode = { "o", "x" },
      desc = "Any quote",
    },
    {
      "au",
      '<cmd>lua require("various-textobjs").url()<CR>',
      mode = { "o", "x" },
      desc = "URL",
    },
    {
      "iu",
      '<cmd>lua require("various-textobjs").url()<CR>',
      mode = { "o", "x" },
      desc = "URL",
    },
    {
      "aF",
      '<cmd>lua require("various-textobjs").filepath("outer")<CR>',
      mode = { "o", "x" },
      desc = "File path",
    },
    {
      "iF",
      '<cmd>lua require("various-textobjs").filepath("inner")<CR>',
      mode = { "o", "x" },
      desc = "File path",
    },
    {
      "dsi",
      function()
        require("various-textobjs").indentation("outer", "outer")
        local indentationFound = vim.fn.mode():find("V")
        if not indentationFound then
          return
        end
        vim.cmd.normal({ "<", bang = true })
        local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1]
        local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1]
        vim.cmd(tostring(endBorderLn) .. " delete")
        vim.cmd(tostring(startBorderLn) .. " delete")
      end,
      mode = { "n" },
      desc = "Delete surrounding indentation",
    },
  },
}
