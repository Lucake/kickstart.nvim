function createTemplateFile(filename, content)
  vim.cmd('echo ' .. content .. ' ' .. filename)
end

local templates = {
  html = function()
    createTemplateFile('index.html', 'teste')
  end,
}

vim.api.nvim_create_user_command('Template', function(opts)
  if templates[opts.args] then
    templates[opts.args]()
  end
end, { nargs = '?' })
