local state = {
  floating = {
    buf = -1,
    win = -1,
    job = nil,
    running = false,
  },
}

local width = math.floor(vim.o.columns * 0.6)
local height = math.floor(vim.o.lines * 0.8)

-- Calculate the position to centre the window
local col = math.floor((vim.o.columns - width) / 2)
local row = math.floor((vim.o.lines - height) / 2)
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

local function create_floating_window(opts)
  opts = opts or {}

  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_configuration)

  return { buf = buf, win = win }
end

local function run_script()
  local script_path = vim.fn.getcwd() .. '/.runner'
  if vim.fn.filereadable(script_path) == 0 then
    vim.notify('No .runner script found in the current directory', vim.log.levels.ERROR)
    return
  end

  local buf = state.floating.buf
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

  local job = vim.fn.jobstart({ 'sh', '-c', 'bash ' .. script_path }, {
    on_stdout = function(_, data)
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
    end,
    on_stderr = function(_, data)
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
    end,
    on_exit = function(_, exit_code)
      state.floating.running = false
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, { 'Script finished with exit code ' .. exit_code })
    end,
  })

  state.floating.job = job
  state.floating.running = true
end

local toggle_floating_runner = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    run_script()
  elseif state.floating.running then
    vim.api.nvim_win_hide(state.floating.win)
  elseif state.floating.job ~= nil then
    vim.api.nvim_open_win(state.floating.buf, true, win_configuration)
  --   vim.api.nvim_win_show(state.floating.win)
  else
    run_script()
  end
end

vim.api.nvim_create_user_command('FloatingRunner', toggle_floating_runner, {})
vim.keymap.set('n', '<leader>r', toggle_floating_runner)
