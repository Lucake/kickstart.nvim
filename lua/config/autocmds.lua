--reset configs when saving config file
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { 'init.lua', 'lua/config/**/*.lua' },
  callback = function(args)
    vim.cmd('source ' .. args.file)
    print('Reloaded ' .. args.file)
  end,
})

--place cursor where i were before closing
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'json', 'yaml', 'html', 'css', 'javascript', 'typescript' },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end,
})

--highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { timeout = 200 }
  end,
})

--auto create parent folde when creating file
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function(event)
    local dir = vim.fn.fnamemodify(event.file, ':p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

--disable auto comment on new line
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

--rainbow parens
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'python', 'json', 'markdown' },
  callback = function()
    vim.wo.colorcolumn = '80'
  end,
})

--parse telekasten as md
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'telekasten',
  callback = function()
    vim.opt_local.syntax = 'markdown'
  end,
})

--close neotree if no file is open
vim.api.nvim_create_autocmd('BufEnter', {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 then
      local buf = vim.api.nvim_get_current_buf()
      local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
      if ft == 'neo-tree' then
        vim.cmd 'quit'
      end
    end
  end,
})

--formating
vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  require('conform').format { async = true, lsp_format = 'fallback', range = range }
end, { range = true })

--equalize buffer size

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufWinLeave', 'VimResized' }, {
  group = vim.api.nvim_create_augroup('WindowManagement', { clear = true }),
  callback = function()
    vim.cmd 'wincmd =' -- Equalize window sizes
  end,
  desc = 'Auto-equalize window sizes on relevant events',
})
