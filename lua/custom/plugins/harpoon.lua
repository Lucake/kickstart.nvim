return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    }

    -- Keymaps
    local map = vim.keymap.set
    local mark = harpoon:list()

    -- Add current file
    map('n', '<leader>ha', function()
      mark:add()
    end, { desc = 'Harpoon Add File' })

    -- Toggle quick menu
    map('n', '<S-Tab>', function()
      harpoon.ui:toggle_quick_menu(mark)
    end, { desc = 'Harpoon Menu' })

    -- Quick jump to files 1-4
    map('n', '<C-h>', function()
      mark:select(1)
    end, { desc = 'Harpoon File 1' })
    map('n', '<C-t>', function()
      mark:select(2)
    end, { desc = 'Harpoon File 2' })
    map('n', '<C-n>', function()
      mark:select(3)
    end, { desc = 'Harpoon File 3' })
    map('n', '<C-s>', function()
      mark:select(4)
    end, { desc = 'Harpoon File 4' })
  end,
}
