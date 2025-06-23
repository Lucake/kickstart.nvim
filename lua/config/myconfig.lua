require 'config.commands'
require 'config.autocmds'
require 'config.shortcuts'
require 'config.notes'

local files = {
  init = 'init.lua',
  notes = 'config\\notes.lua',
  commands = 'config\\commands.lua',
  myconfig = 'config\\myconfig.lua',
  autocmds = 'config\\autocmds.lua',
  shortcuts = 'config\\shortcuts.lua',
  templates = 'config\\template.lua',

  snippets = 'config\\snippets',
  themes = 'config\\themes.lua',
  plugins = '\\custom\\plugins',
}

vim.api.nvim_create_user_command('Cfg', function(opts)
  local configPath = 'C:\\Users\\Usuario\\AppData\\Local\\nvim\\'
  vim.cmd('cd ' .. configPath)

  if opts.args == '' then
    vim.cmd('e ' .. files['init'])
    return
  end

  if opts.args == '-r' then
    vim.cmd 'source $MYVIMRC'

    local prefix = 'config.'
    for module_name, _ in pairs(package.loaded) do
      if module_name:match('^' .. prefix) then
        package.loaded[module_name] = nil
      end
    end

    require 'config.commands'
    require 'config.myconfig'
    require 'config.autocmds'
    require 'config.shortcuts'
    require 'config.template'
    require 'config.themes'
    require 'custom.plugins'
    require 'config.notes'

    print 'Config reloaded with Lua modules!'

    return
  end

  if opts.args == '-h' then
    print 'available commands:'
    for k, _ in pairs(files) do
      print('/n -' .. k)
    end

    return
  end
  if files[opts.args] then
    vim.cmd('e ' .. configPath .. '\\lua\\' .. files[opts.args])
    return
  end

  print 'config file not found'
end, {
  nargs = '?',
  complete = function(ArgLead, CmdLine, CursorPos)
    local matches = {}
    for k, _ in pairs(files) do
      if k:find('^' .. ArgLead) then
        table.insert(matches, k)
      end
    end
    return matches
  end,
})
