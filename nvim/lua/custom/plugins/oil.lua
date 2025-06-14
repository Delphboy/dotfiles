return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
    config = function()
      require('oil').setup {
        columns = { 'icon' },
        keymaps = {
          ['<C-h>'] = false,
          ['<C-p>'] = false,
          ['<M-h>'] = 'action.select_split',
        },
        view_options = { show_hidden = true },
        float = {
          padding = 2,
          max_width = 120,
          max_height = 80,
          border = 'double',
        },
      }
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
      vim.keymap.set('n', '<leader>-', require('oil').toggle_float, { desc = 'Open parent in floating window' })
    end,
  },
}
