return {
  'nvim-treesitter/playground',
  cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('nvim-treesitter.configs').setup {
      playground = {
        enable = true,
        updatetime = 25, -- Debounced time for highlighting nodes
        persist_queries = false, -- Don't save queries per filetype
      },
    }
  end,
}
