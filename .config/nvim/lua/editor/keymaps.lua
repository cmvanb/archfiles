-- TODO: Clear existing key mappings when reloading.
--------------------------------------------------------------------------------
-- Editor key mappings
--------------------------------------------------------------------------------

-- TODO: Extract utility.
-- Helpers
--------------------------------------------------------------------------------

local function _map(mode, shortcut, command, silent)
    silent = silent or false
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = false, silent = silent })
end

local function _noremap(mode, shortcut, command, silent)
    silent = silent or false
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = silent })
end

local function map(shortcut, command, silent)
    silent = silent or false
    _map('', shortcut, command, silent)
end

local function nmap(shortcut, command, silent)
    silent = silent or false
    _map('n', shortcut, command, silent)
end

local function vmap(shortcut, command, silent)
    silent = silent or false
    _map('v', shortcut, command, silent)
end

local function xmap(shortcut, command, silent)
    silent = silent or false
    _map('x', shortcut, command, silent)
end

local function imap(shortcut, command, silent)
    silent = silent or false
    _map('i', shortcut, command, silent)
end

local function noremap(shortcut, command, silent)
    silent = silent or false
    _noremap('', shortcut, command, silent)
end

local function nnoremap(shortcut, command, silent)
    silent = silent or false
    _noremap('n', shortcut, command, silent)
end

local function vnoremap(shortcut, command, silent)
    silent = silent or false
    _noremap('v', shortcut, command, silent)
end

local function xnoremap(shortcut, command, silent)
    silent = silent or false
    _noremap('x', shortcut, command, silent)
end

local function onoremap(shortcut, command, silent)
    silent = silent or false
    _noremap('o', shortcut, command, silent)
end

-- Mappings
--------------------------------------------------------------------------------

-- Disable default mappings
map('q', '<nop>')
map('Q', '<nop>')

map('H', '<nop>')
map('J', '<nop>')
map('K', '<nop>')
map('L', '<nop>')

map('<C-w>c', '<nop>')
map('<C-w>w', '<nop>')
map('<C-w>W', '<nop>')
map('<C-w>r', '<nop>')

map('<C-o>', '<nop>')

map('<C-h>', '<nop>')
map('<C-j>', '<nop>')
map('<C-k>', '<nop>')
map('<C-l>', '<nop>')

map('<C-n>', '<nop>')
map('<C-p>', '<nop>')
imap('<C-n>', '<nop>')
imap('<C-p>', '<nop>')

-- Leader key
nnoremap(' ', '')
xnoremap(' ', '')
vim.g.mapleader = ' '

-- TODO: Extract to leap config.
-- Leap
noremap('<leader>f', '<plug>(leap-forward)')
noremap('<leader>F', '<plug>(leap-backward)')

-- Visual block select
noremap('<leader>v', '<C-v>')

-- System clipboard
-- NOTE: This is only working in TUI because Wezterm is configured for it.
vnoremap('<C-c>', '"+y')
noremap('<C-v>', '"+p')
noremap('<C-x>', 'x')

-- Windows style binds
noremap('<C-a>', 'gg0vG$')
noremap('<C-z>', 'u')

-- TODO: Extract to telescope config.
-- Fuzzy finder
noremap('<leader>o', '<cmd>Telescope git_files<cr>')
noremap('<leader>p', '<cmd>Telescope find_files hidden=true no_ignore=true<cr>')
noremap('<leader>b', '<cmd>Telescope buffers<cr>')
noremap('<leader>g', '<cmd>Telescope live_grep<cr>')
noremap('<leader>i', '<cmd>Telescope symbols<cr>')

-- Start/end of line
nnoremap('H', '0')
nnoremap('L', '$')
xnoremap('H', '0')
xnoremap('L', '$')
onoremap('H', '0')
onoremap('L', '$')

-- Swap lines
nnoremap('J', '<esc>:m .+1<cr>==')
nnoremap('K', '<esc>:m .-2<cr>==')

-- Change window focus
noremap('<C-m>', '<C-w>r <bar> <C-w>W')
noremap('<C-j>', '<C-w>w')
noremap('<C-k>', '<C-w>W')

-- Change buffer
noremap('<C-h>', ':bprev<cr>')
noremap('<C-l>', ':bnext<cr>')

-- Split windows
nnoremap('<C-n>', '<esc>:vnew<cr>')
nnoremap('<C-p>', '<esc>:new<cr>')

-- Close NVIM without saving
noremap('<C-S-q>', ':qa!<cr>')

-- Save all buffers
noremap('<C-s>', ':wa!<cr>')

-- Close buffer
noremap('<C-q>', ':bd<cr>')

-- Close window
noremap('<C-w>q', ':close<cr>')

-- Clear search buffer, clear command line and go to start of line
noremap('<leader>l', '<cmd>let @/=""<cr>:echo ""<cr>', true)

-- Formatting
noremap(';', '=')
noremap('<leader>;', 'gg=G')

