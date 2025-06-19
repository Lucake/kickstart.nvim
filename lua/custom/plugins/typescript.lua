return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  opts = {
    settings = {
      typescript = {
        format = {
          indentSize = 2,
          tabSize = 2,
          convertTabsToSpaces = true,
        },
      },
      javascript = {
        format = {
          indentSize = 2,
          tabSize = 2,
          convertTabsToSpaces = true,
        },
      },
    },
  },
  config = function(_, opts)
    require('typescript-tools').setup(vim.tbl_deep_extend('force', opts, {
      on_attach = function(client, bufnr)
        -- Disable LSP formatting capability so Conform can take over
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
    }))
  end,
}
