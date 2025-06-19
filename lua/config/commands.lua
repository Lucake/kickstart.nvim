--              /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\
--             ( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )
--              > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <
--              /\_/\                                                                                      /\_/\
--             ( o.o )         __  ___         ______                                          __         ( o.o )
--              > ^ <         /  |/  /_  __   / ____/___  ____ ___  ____ ___  ____ _____  ____/ /____      > ^ <
--              /\_/\        / /|_/ / / / /  / /   / __ \/ __ `__ \/ __ `__ \/ __ `/ __ \/ __  / ___/      /\_/\
--             ( o.o )      / /  / / /_/ /  / /___/ /_/ / / / / / / / / / / / /_/ / / / / /_/ (__  )      ( o.o )
--              > ^ <      /_/  /_/\__, /   \____/\____/_/ /_/ /_/_/ /_/ /_/\__,_/_/ /_/\__,_/____/        > ^ <
--              /\_/\             /____/                                                                   /\_/\
--             ( o.o )                                                                                    ( o.o )
--              > ^ <                                                                                      > ^ <
--              /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\
--             ( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )
--              > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <

--

-- open config files
prompts = {
  IA = 'C:\\Users\\Usuario\\Desktop\\raposo.os\\Instituto Aliança',
  Projects = 'C:\\Users\\Usuario\\Desktop\\raposo.os\\Personal',
  Notes = 'C:\\Users\\Usuario\\Desktop\\raposo.os\\Notes',
  Stacks = 'C:\\Users\\Usuario\\Desktop\\raposo.os\\Personal\\Stacks\\Stacks',
}

for key, path in pairs(prompts) do
  vim.api.nvim_create_user_command(key, function(opts)
    vim.cmd('cd ' .. path .. '\\' .. opts.args)
    vim.cmd 'e.'
  end, { nargs = '?' })
end

local terminalCommands = {
  Theme = 'Telescope colorscheme',
}

for key, command in pairs(terminalCommands) do
  vim.api.nvim_create_user_command(key, function(opts)
    vim.cmd(command)
  end, { nargs = '?' })
end

local languages = {
  lua = '%lua',
  javascript = '!node %',
}

--run code based on language
vim.api.nvim_create_user_command('Run', function()
  local filetype = vim.bo.filetype
  if languages[filetype] then
    vim.cmd(languages[filetype])
    return
  end
  print 'language not found'
end, {})

--chat-GPT commands
local prompts = {
  Key = 'NeoAI what are the best way on neovim to:',
  AI = 'NeoAI ',
  Review = 'NeoAIContext review my code',
  Context = 'NeoAIContext',
}

for key, command in pairs(prompts) do
  vim.api.nvim_create_user_command(key, function(opts)
    vim.cmd(command .. ' ' .. opts.args)
  end, { nargs = '?' })
end
