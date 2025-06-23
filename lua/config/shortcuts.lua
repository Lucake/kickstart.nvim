vim.keymap.set('n', '<leader>[', '<Cmd>Neotree toggle<Cr>')
vim.keymap.set('n', '<leader>]', '<Cmd>Neotree float reveal<Cr>')
vim.keymap.set({ 'n', 'x', 'i', 's' }, '<C-s>', '<Cmd>w<Cr>')

-- Buffer Navigation
vim.keymap.set('n', '<Alt>]', '<Cmd>bnext<CR>', { noremap = true, silent = true, desc = 'Buffer: Next' })
vim.keymap.set('n', '<Alt>[', '<Cmd>bprevious<CR>', { noremap = true, silent = true, desc = 'Buffer: Previous' })

--Notes
-- Launch panel if nothing is typed after <leader>z
vim.keymap.set('n', '<leader>z', '<cmd>Telekasten panel<CR>')

-- Most used functions
vim.keymap.set('n', '<leader>zf', '<cmd>Telekasten find_notes<CR>')
vim.keymap.set('n', '<leader>zg', '<cmd>Telekasten search_notes<CR>')
vim.keymap.set('n', '<leader>zd', '<cmd>Telekasten goto_today<CR>')
vim.keymap.set('n', '<leader>zz', '<cmd>Telekasten follow_link<CR>')
vim.keymap.set('n', '<leader>zn', '<cmd>Telekasten new_note<CR>')
vim.keymap.set('n', '<leader>zc', '<cmd>Telekasten show_calendar<CR>')
vim.keymap.set('n', '<leader>zb', '<cmd>Telekasten show_backlinks<CR>')
vim.keymap.set('n', '<leader>zI', '<cmd>Telekasten insert_img_link<CR>')

-- Call insert link automatically when we start typing a link
vim.keymap.set('i', '[[', '<cmd>Telekasten insert_link<CR>')

vim.keymap.set('n', '<leader>r', '<cmd>Run<CR>')

-- Lua ;toggleterm
vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>')
vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>')
vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>')

-- git

-- move line up and down
vim.keymap.set('n', '<A-down>', 'ddp', { noremap = true, silent = true, desc = 'Buffer: Previous' })
vim.keymap.set('n', '<A-Up>', 'dd<Up><S-p>', { noremap = true, silent = true, desc = 'Buffer: Previous' })
vim.keymap.set('n', '<A-y>', 'yyp', { noremap = true, silent = true, desc = 'Buffer: Previous' })

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new { cmd = 'lazygit', hidden = true }

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>cr', '<cmd>Cfg -r<CR>')

--harpoodn
local harpoon = require 'harpoon'
--change list
function _G.HarpoonSwitchList()
  local list_name = vim.fn.input 'Harpoon list name: '
  if list_name == '' then
    return
  end
  _G.HARPOON_CURRENT = harpoon:list(list_name)
  print('Switched to Harpoon list: ' .. list_name)
end
vim.keymap.set('n', '<leader>hl', HarpoonSwitchList, { desc = 'Switch Harpoon List' })

--add all files to list
local Path = require 'plenary.path'
local scan = require 'plenary.scandir'

function _G.AddAllFilesInCurrentFolder()
  local buf_path = vim.api.nvim_buf_get_name(0)
  local dir = vim.fn.fnamemodify(buf_path, ':p:h')

  if dir == nil or dir == '' then
    print 'No valid directory.'
    return
  end

  local files = scan.scan_dir(dir, { hidden = false, depth = 1 })

  for _, file in ipairs(files) do
    _G.HARPOON_CURRENT:add(file)
  end

  print('Added ' .. #files .. ' files from: ' .. dir)
end

-- Keymap
vim.keymap.set('n', '<leader>hf', AddAllFilesInCurrentFolder, { desc = 'Add all files in current folder to Harpoon' })
