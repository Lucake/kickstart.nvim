require('telekasten').setup {
  home = vim.fn.expand 'C:/Users/Usuario/Desktop/raposo.os/Notes',
  templates = vim.fn.expand 'C:/Users/Usuario/Desktop/raposo.os/Notes/templates/',
}

-- Change styling

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  callback = function()
    local path = vim.api.nvim_buf_get_name(0)
    -- Adjust this to your telekasten notes directory
    if path:match(vim.fn.expand 'C:/Users/Usuario/Desktop/raposo.os/Notes/') then
      vim.bo.filetype = 'markdown'
    end
  end,
})

local colors = {
  primary = '#f06292',
  primaryDark = '#ad5d78',
  bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg,
  fg = '#8990ad',
}

local formats = {
  primaryBold = {
    formating = { fg = colors.primary, bold = true },
    elements = {
      '@markup.heading.1.markdown',
      '@markup.heading.2.markdown',
      '@markup.heading.3.markdown',
      '@markup.heading.4.markdown',
      '@markup.heading.5.markdown',
      '@markup.heading.6.markdown',
      '@markup.list.markdown',
      '@punctuation.special.markdown',
      '@markup.strong.markdown_inline',
    },
  },
  normal = {
    formating = { fg = colors.fg, bg = colors.bg },
    elements = {
      'normal',
    },
  },
  highlight = {
    formating = { fg = '#ff0000', bg = colors.primaryDark, bold = true },
    elements = {
      '@markup.raw.markdown_inline',
    },
  },
  highlightLimiter = {
    formating = { fg = colors.primary, bg = colors.primary },
    elements = {
      'markdownCodeDelimiter',
    },
  },
  bold = {
    formating = { bold = true },
    elements = {
      'markdownBold',
    },
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    -- Override Tree-sitter highlight groups for Markdown only
    for key, value in pairs(formats) do
      for index, element in ipairs(value.elements) do
        vim.api.nvim_set_hl(0, element, value.formating)
      end
    end
  end,
})
