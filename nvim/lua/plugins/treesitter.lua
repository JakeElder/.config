return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
  },
  config = function()
    vim.treesitter.language.register("bash", "zsh")
    vim.treesitter.language.register("markdown", "mdx")
    vim.filetype.add({ extension = { mdx = "mdx" } })

    require("nvim-treesitter").setup()

    require("nvim-treesitter").install({
      "lua",
      "javascript",
      "typescript",
      "tsx",
      "html",
      "css",
      "json",
      "yaml",
      "markdown",
      "markdown_inline",
      "bash",
      "helm",
      "gotmpl",
      "terraform",
      "hcl",
    })

    -- Highlighting and indentation are now built into Neovim 0.12
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        if pcall(vim.treesitter.start) then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    -- Incremental selection (removed from nvim-treesitter, manual implementation)
    local sel_stack = {}

    local function select_node(node)
      local sr, sc, er, ec = node:range()
      if ec > 0 then
        vim.cmd(string.format("normal! \27%dG%d|v%dG%d|", sr + 1, sc + 1, er + 1, ec))
      else
        vim.cmd(string.format("normal! \27%dG%d|v%dG$", sr + 1, sc + 1, er))
      end
    end

    vim.keymap.set("n", "*", function()
      local node = vim.treesitter.get_node()
      if not node then
        return
      end
      sel_stack = { node }
      select_node(node)
    end, { desc = "Init treesitter selection" })

    vim.keymap.set("x", "*", function()
      if #sel_stack == 0 then
        return
      end
      local parent = sel_stack[#sel_stack]:parent()
      if not parent then
        return
      end
      table.insert(sel_stack, parent)
      select_node(parent)
    end, { desc = "Expand treesitter selection" })

    vim.keymap.set("x", "_", function()
      if #sel_stack <= 1 then
        return
      end
      table.remove(sel_stack)
      select_node(sel_stack[#sel_stack])
    end, { desc = "Shrink treesitter selection" })

    -- Textobjects
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
        selection_modes = {
          ["@import.outer"] = "V",
          ["@export.outer"] = "V",
        },
      },
      move = {
        set_jumps = true,
      },
    })

    local ts_select = require("nvim-treesitter-textobjects.select")
    local function sel(lhs, query, desc)
      vim.keymap.set({ "x", "o" }, lhs, function()
        ts_select.select_textobject(query, "textobjects")
      end, { desc = desc })
    end

    sel("aa", "@assignment.outer", "Assignment")
    sel("ia", "@assignment.outer", "Assignment")
    sel("ag", "@argument.outer", "Argument")
    sel("ig", "@argument.outer", "Argument")
    sel("av", "@assignment.rhs", "Assignment value")
    sel("iv", "@assignment.rhs", "Assignment value")
    sel("ik", "@assignment.lhs", "Assignment key")
    sel("af", "@function.outer", "Function")
    sel("if", "@function.inner", "Function body")
    sel("ar", "@return.outer", "Return statement")
    sel("ir", "@return.inner", "Return value")
    sel("ac", "@call.outer", "Call")
    sel("ic", "@call.inner", "Call arguments")
    sel("a/", "@comment.outer", "Comment")
    sel("ah", "@heading.outer", "Heading")
    sel("a.", "@element.outer", "Element")
    sel("i.", "@element.outer", "Element")
    sel("ax", "@regex.outer", "Regex")
    sel("ix", "@regex.outer", "Regex")
    sel("as", "@source.outer", "Source/String")
    sel("is", "@source.inner", "Source content")
    sel("al", "@loop.outer", "Loop")
    sel("il", "@loop.inner", "Loop body")

    local ts_move = require("nvim-treesitter-textobjects.move")
    local function move_next(lhs, query, desc)
      vim.keymap.set({ "n", "x", "o" }, lhs, function()
        ts_move.goto_next_start(query, "textobjects")
      end, { desc = desc })
    end
    local function move_prev(lhs, query, desc)
      vim.keymap.set({ "n", "x", "o" }, lhs, function()
        ts_move.goto_previous_start(query, "textobjects")
      end, { desc = desc })
    end

    move_next("]f", "@function.outer", "Next function")
    move_next("]a", "@assignment.outer", "Next assignment")
    move_next("]g", "@argument.outer", "Next argument")
    move_next("]k", "@assignment.lhs", "Next key")
    move_next("]v", "@assignment.rhs", "Next value")
    move_next("]d", "@type.outer", "Next definition/type")
    move_next("]r", "@return.outer", "Next return")
    move_next("]c", "@call.outer", "Next call")
    move_next("]/", "@comment.outer", "Next comment")
    move_next("]i", "@import.outer", "Next import")
    move_next("]e", "@export.outer", "Next export")
    move_next("]h", "@heading.outer", "Next heading")
    move_next("].", "@element.outer", "Next element")
    move_next("]s", "@source.outer", "Next source/string")
    move_next("]l", "@loop.outer", "Next loop")
    move_next("]b", "@conditional.outer", "Next conditional")
    move_next("]q", "@string.outer", "Next string")
    move_next("]x", "@regex.outer", "Next regex")
    move_next("]t", "@tag", "Next tag")
    move_next("]p", "@parameter.outer", "Next parameter")

    move_prev("[f", "@function.outer", "Previous function")
    move_prev("[a", "@assignment.outer", "Previous assignment")
    move_prev("[g", "@argument.outer", "Previous argument")
    move_prev("[k", "@assignment.lhs", "Previous key")
    move_prev("[v", "@assignment.rhs", "Previous value")
    move_prev("[d", "@type.outer", "Previous definition/type")
    move_prev("[r", "@return.outer", "Previous return")
    move_prev("[c", "@call.outer", "Previous call")
    move_prev("[/", "@comment.outer", "Previous comment")
    move_prev("[i", "@import.outer", "Previous import")
    move_prev("[e", "@export.outer", "Previous export")
    move_prev("[h", "@heading.outer", "Previous heading")
    move_prev("[.", "@element.outer", "Previous element")
    move_prev("[s", "@source.outer", "Previous source/string")
    move_prev("[l", "@loop.outer", "Previous loop")
    move_prev("[b", "@conditional.outer", "Previous conditional")
    move_prev("[q", "@string.outer", "Previous string")
    move_prev("[x", "@regex.outer", "Previous regex")
    move_prev("[t", "@tag", "Previous tag")
    move_prev("[p", "@parameter.outer", "Previous parameter")

    local ts_repeat = require("nvim-treesitter-textobjects.repeatable_move")
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat.repeat_last_move)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat.repeat_last_move_opposite)
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat.builtin_T_expr, { expr = true })

    local next_non_ascii = ts_repeat.make_repeatable_move(function()
      vim.fn.search("[^\\x00-\\x7F]", "W")
    end)
    local prev_non_ascii = ts_repeat.make_repeatable_move(function()
      vim.fn.search("[^\\x00-\\x7F]", "bW")
    end)

    -- Unicode chars
    vim.keymap.set({ "n", "x", "o" }, "]u", next_non_ascii, { desc = "Next non-ASCII", silent = true })
    vim.keymap.set({ "n", "x", "o" }, "[u", prev_non_ascii, { desc = "Prev non-ASCII", silent = true })
  end,
}
