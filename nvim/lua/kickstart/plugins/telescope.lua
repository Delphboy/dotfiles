return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },

    config = function()
      local default_style = {
        prompt_position = 'bottom',
        layout_config = {
          width = 140,
          height = 30,
          preview_width = 85,
        },
      }
      local ivy_style = {
        theme = 'ivy',
        prompt_position = 'top',
        layout_config = {
          width = 140,
          height = 15,
          preview_width = 0.8,
        },
      }
      local cursor_style = {
        theme = 'cursor',
        layout_config = {
          width = 160,
          height = 15,
          preview_width = 0.75,
        },
      }
      require('telescope').setup {
        pickers = {
          -- file/buffer changes should take up whole screen
          find_files = default_style,
          buffers = default_style,

          -- LSP
          lsp_type_definitions = cursor_style,
          lsp_document_symbols = ivy_style,
          lsp_dynamic_workspace_symbols = ivy_style,
          lsp_definitions = cursor_style,
          lsp_references = cursor_style,
          lsp_implementations = cursor_style,

          -- other searching should keep context
          live_grep = ivy_style,
          grep_string = ivy_style,
          diagnostics = ivy_style,
          help_tags = ivy_style,
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>fH', builtin.help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Find Files' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fT', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
      vim.keymap.set('n', '<leader>fq', builtin.diagnostics, { desc = '[F]ind Diagnostics [Q]ueue' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
      vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.api.nvim_set_keymap('n', '<leader>ft', ':TodoTelescope<CR>', { noremap = true, silent = true })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>.', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[.] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[F]ind [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
