--------------------------------------------------------------------------------
-- Editor key mappings
--------------------------------------------------------------------------------

-- TODO: Extract map functions to utility.
-- TODO: Better options parameter for map functions.
-- TODO: Clear existing key mappings when reloading.

-- Helpers
--------------------------------------------------------------------------------

local function _map(mode, shortcut, command, silent)
    silent = silent or false
    vim.keymap.set(mode, shortcut, command, { noremap = false, silent = silent })
end

local function _noremap(mode, shortcut, command, silent)
    silent = silent or false
    vim.keymap.set(mode, shortcut, command, { noremap = true, silent = silent })
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

-- Disable default mappings
--------------------------------------------------------------------------------

map('q', '<nop>')
map('Q', '<nop>')

map('H', '<nop>')
map('J', '<nop>')
map('K', '<nop>')
map('L', '<nop>')

map('<C-o>', '<nop>')

map('<C-h>', '<nop>')
map('<C-j>', '<nop>')
map('<C-k>', '<nop>')
map('<C-l>', '<nop>')

map('<C-n>', '<nop>')
map('<C-p>', '<nop>')
imap('<C-n>', '<nop>')
imap('<C-p>', '<nop>')

map('<CR>', '<nop>')

map('ga', '<nop>')
map('gd', '<nop>')
map('ge', '<nop>')
map('gD', '<nop>')
map('gh', '<nop>')
map('gH', '<nop>')
map('gi', '<nop>')
map('go', '<nop>')
map('gr', '<nop>')

-- Leader key
--------------------------------------------------------------------------------

nnoremap(' ', '')
xnoremap(' ', '')
vim.g.mapleader = ' '

-- Convenience
--------------------------------------------------------------------------------

-- System clipboard
-- NOTE: This is only working in TUI because Wezterm is configured for it.
vnoremap('<C-c>', '"+y')
noremap('<C-v>', '"+p')
noremap('<C-x>', 'x')

-- Windows style binds
noremap('<C-a>', 'gg0vG$')
noremap('<C-z>', 'u')

-- Selection
--------------------------------------------------------------------------------

-- Visual selection expansion powered by nvim-treesitter.
nmap('+', 'gnn')
nmap('-', '<nop>')
xmap('+', 'grn')
xmap('-', 'grm')

-- Visual block select
noremap('<leader>v', '<C-v>')

-- Navigation
--------------------------------------------------------------------------------

-- Start/end of line
nnoremap('H', '0')
nnoremap('L', '$')
xnoremap('H', '0')
xnoremap('L', '$')
onoremap('H', '0')
onoremap('L', '$')

-- Leap
noremap('<leader>j', function() require('leap').leap({}) end)
noremap('<leader>k', function() require('leap').leap({ backward = true }) end)

-- Editing
--------------------------------------------------------------------------------

-- Swap lines
nnoremap('J', '<esc>:m .+1<cr>==', true)
nnoremap('K', '<esc>:m .-2<cr>==', true)

-- Formatting
noremap(';', '=')
noremap('<leader>;', 'gg=G')

-- Search
--------------------------------------------------------------------------------

-- Fuzzy finder
noremap('<leader>a', '<cmd>Telescope find_files hidden=true no_ignore=true<cr>')
noremap('<leader>d', '<cmd>Telescope find_files<cr>')
noremap('<leader>f', '<cmd>Telescope git_files<cr>')
noremap('<leader>b', '<cmd>Telescope buffers<cr>')
noremap('<leader>g', '<cmd>Telescope live_grep<cr>')
noremap('<leader>i', '<cmd>Telescope symbols<cr>')

-- Clear search buffer, clear command line and go to start of line
noremap('<leader>l', '<cmd>noh<cr>:echo ""<cr>')

-- Windows
--------------------------------------------------------------------------------

-- Change window focus
noremap('<C-h>', '<C-w>h')
noremap('<C-j>', '<C-w>j')
noremap('<C-k>', '<C-w>k')
noremap('<C-l>', '<C-w>l')

-- Cycle window focus
noremap('<C-z>', '<C-w>r')

-- Split windows
nnoremap('<C-n>', '<esc>:belowright vnew<cr>', true)
nnoremap('<C-p>', '<esc>:belowright new<cr>', true)

-- Close window
noremap('<C-w>', ':close<cr>', true)

-- Buffers
--------------------------------------------------------------------------------

-- Change buffer
-- NOTE: Wezterm translates <C-BS> to <F15> for us.
noremap('<F15>', ':bprev<cr>', true)
noremap('<C-Tab>', ':bnext<cr>', true)

-- Save all buffers
noremap('<C-s>', ':wa!<cr>')

-- Close buffer
nnoremap('<C-q>', ':Bdelete<cr>', true)

-- Close NVIM without saving
noremap('<Leader>q', ':qa!<cr>')

-- Sessions
--------------------------------------------------------------------------------

noremap('<leader>s', '<cmd>SessionsSave<cr>:echo "Session saved."<cr>')
noremap('<leader>o', '<cmd>SessionsLoad<cr>:echo "Session loaded."<cr>')

-- Plugin management
--------------------------------------------------------------------------------

-- TODO: Add key to reload full config.

-- Reload plugins.
noremap('<leader>r', Loader.reload_plugins, true)

