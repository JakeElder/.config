local M = {}

local function feedkeys_esc()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", false)
end

local function clear_statusline()
  vim.api.nvim_echo({}, false, {})
end

function M.escape()
  -- close floating windows first
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, false)
      feedkeys_esc()
      return
    end
  end
  -- then clear search highlight
  if vim.v.hlsearch == 1 then
    vim.v.hlsearch = false
    feedkeys_esc()
    return
  end
  -- always clear status line
  clear_statusline()
  feedkeys_esc()
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

function M.toggle_wrap()
  vim.wo.wrap = not vim.wo.wrap
  vim.notify("wrap " .. (vim.wo.wrap and "on" or "off"))
end

function M.toggle_list()
  vim.wo.list = not vim.wo.list
  vim.notify("list " .. (vim.wo.list and "on" or "off"))
end

function M.tmux_navigate(direction)
  local nr = vim.fn.winnr()
  vim.cmd("wincmd " .. direction)
  if nr == vim.fn.winnr() then
    local tmux_dir = ({ h = "L", j = "D", k = "U", l = "R" })[direction]
    vim.fn.system("tmux select-pane -" .. tmux_dir)
  end
end

return M
