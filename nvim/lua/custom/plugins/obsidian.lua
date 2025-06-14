return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    -- 'BufReadPre /home/henry/Documents/notes/**/*.md',
    -- 'BufNewFile /home/henry/Documents/notes/**/*.md',
  },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>nd', ':ObsidianToday<cr>', desc = 'obsidian [d]aily' },
    { '<leader>nt', ':ObsidianToday 1<cr>', desc = 'obsidian [t]omorrow' },
    { '<leader>ny', ':ObsidianToday -1<cr>', desc = 'obsidian [y]esterday' },
    { '<leader>nb', ':ObsidianBacklinks<cr>', desc = 'obsidian [b]acklinks' },
    { '<leader>nl', ':ObsidianLink<cr>', desc = 'obsidian [l]ink selection' },
    { '<leader>nf', ':ObsidianFollowLink<cr>', desc = 'obsidian [f]ollow link' },
    { '<leader>nn', ':ObsidianNew<cr>', desc = 'obsidian [n]ew' },
    { '<leader>ns', ':ObsidianSearch<cr>', desc = 'obsidian [s]earch' },
    { '<leader>no', ':ObsidianQuickSwitch<cr>', desc = 'obsidian [o]pen quickswitch' },
    { '<leader>nO', ':ObsidianOpen<cr>', desc = 'obsidian [O]pen in app' },
  },
  opts = {
    workspaces = {
      {
        name = 'notes',
        path = '/home/henry/Documents/notes/',
      },
    },

    -- see below for full list of options 👇
  },
}
