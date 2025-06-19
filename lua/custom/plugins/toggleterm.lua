return {
  'akinsho/toggleterm.nvim',
  version = '*', -- or a specific tag
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<c-\>]], -- Toggle with Ctrl + \
      direction = 'float', -- Terminal opens in a floating window
      start_in_insert = true, -- Start in insert mode
      terminal_mappings = true, -- Enable terminal keymaps
    }
  end,
}
