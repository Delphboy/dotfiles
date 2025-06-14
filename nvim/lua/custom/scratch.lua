local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.6)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate the position to centre the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create buffer
  local buf = nil
  local file_path = vim.fn.getcwd() .. '/run.sh'
  if vim.fn.filereadable(file_path) == 1 then
    buf = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_buf_set_name(buf, file_path)
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Read the file and insert its contents into the buffer
  local file_path = vim.fn.getcwd() .. '/run.sh'
  if vim.fn.filereadable(file_path) == 1 then
    local lines = vim.fn.readfile(file_path)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  end

  -- Define window configuration
  local win_configuration = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'double',
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_configuration)

  return { buf = buf, win = win }
end

local toggle_window = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.api.nvim_create_user_command('FloatingScratchWindow', toggle_window, {})
vim.keymap.set('n', '<leader>=', toggle_window)
