local M = {}

function M.clear_search()
  vim.v.hlsearch = false
  vim.api.nvim_echo({}, false, {})
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", false)
end

function M.show_path()
  print(vim.fn.expand("%:p"))
end

function M.copy_path()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Path copied: " .. path)
end

function M.quickfix_next()
  vim.cmd("silent! cnext")
end

function M.quickfix_prev()
  vim.cmd("silent! cprev")
end

function M.quickfix_toggle()
  local qf_open = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      qf_open = true
      break
    end
  end
  if qf_open then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end

function M.reload_all_buffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      vim.api.nvim_buf_call(buf, function()
        vim.cmd("e!")
      end)
    end
  end
end

return M
