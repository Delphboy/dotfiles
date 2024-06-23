return {
  {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    branch = 'harpoon2',
    config = function()
      local harpoon = require 'harpoon'

      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      vim.keymap.set('n', '<leader>hh', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, {
        desc = 'Toggle harpoon quick menu',
      })

      -- Telescope powers our finder
      vim.keymap.set('n', '<leader>fh', function()
        toggle_telescope(harpoon:list())
      end, { desc = 'Open harpoon window' })

      harpoon:setup {
        settings = {
          save_on_toggle = true,
        },
      }

      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end, { desc = 'Add current file to harpoon' })

      vim.keymap.set('n', '<leader>hd', function()
        harpoon:list():add()
      end, { desc = 'Add current file to harpoon' })

      local function set_navigation(number)
        vim.keymap.set('n', '<leader>h' .. number, function()
          harpoon:list():select(number)
        end, { desc = 'Go to harpoon ' .. number })
      end
      set_navigation(1)
      set_navigation(2)
      set_navigation(3)
      set_navigation(4)
      set_navigation(5)
      set_navigation(6)
      set_navigation(7)
      set_navigation(8)
      set_navigation(9)

      local function set_replace(number)
        vim.keymap.set('n', '<leader>hr' .. number, function()
          harpoon:list():replace_at(number)
        end, { desc = 'Go to harpoon ' .. number })
      end

      set_replace(1)
      set_replace(2)
      set_replace(3)
      set_replace(4)
      set_replace(5)
      set_replace(6)
      set_replace(7)
      set_replace(8)
      set_replace(9)
    end,
  },
}
