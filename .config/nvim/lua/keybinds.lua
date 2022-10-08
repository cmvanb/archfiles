--------------------------------------------------------------------------------
-- Neovim key bindings
--------------------------------------------------------------------------------

-- Helpers
--------------------------------------------------------------------------------

local cmd = vim.cmd
local opt = vim.opt
local api = vim.api
local fn = vim.fn
local g = vim.g

function _map(mode, shortcut, command, silent)
    silent = silent or false
    api.nvim_set_keymap(mode, shortcut, command, { noremap = false, silent = silent })
end

function _noremap(mode, shortcut, command)
    silent = silent or false
    api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = silent })
end

function map(shortcut, command, silent)
    silent = silent or false
    _map('', shortcut, command, silent)
end

function noremap(shortcut, command, silent)
    silent = silent or false
    _noremap('', shortcut, command, silent)
end

function vnoremap(shortcut, command, silent)
    silent = silent or false
    _noremap('v', shortcut, command, silent)
end

-- Bindings
--------------------------------------------------------------------------------

-- Disable default bindings
map('f', '<nop>')
map('F', '<nop>')
map('q', '<nop>')
map('Q', '<nop>')
map('<C-w>c', '<nop>')

-- Leader key
g.mapleader = ' '

-- Visual block select
noremap('<leader>v', '<C-v>')

-- System clipboard
-- NOTE: This is only working (in TUI) because Wezterm is configured for it.
vnoremap('<C-c>', '"+y')
noremap('<C-v>', '"+p')

-- Fuzzy finder
noremap('<leader>o', '<cmd>Telescope find_files hidden=true no_ignore=true<cr>')
noremap('<leader>b', '<cmd>Telescope buffers<cr>')
noremap('<leader>g', '<cmd>Telescope live_grep<cr>')
noremap('<leader>i', '<cmd>Telescope symbols<cr>')

-- Switch buffers
noremap('<leader>h', ':bprev<cr>')
noremap('<leader>l', ':bnext<cr>')

-- Close program without saving
noremap('<C-q>', ':qa!<cr>')

-- Save buffer
noremap('<C-s>', ':wa<cr>')

-- Close buffer
noremap('<leader>q', ':bd<cr>')

-- Close window
noremap('<C-w>q', ':close<cr>')

-- Jump
noremap('f', '<plug>(leap-forward)')
noremap('F', '<plug>(leap-backward)')

-- Comment out selection (VISUAL) or current line (NORMAL)
-- NOTE: This is from `mini.comment` plugin.
-- NOTE: Does this need to be `map`?
map('<leader>/', 'gcc<esc>')


-- Reload configuration
-- NOTE: This binding is unnecessary since all configuration automatically reloads.
-- noremap('<leader>r', '<cmd>source $MYVIMRC<bar>echo "Configuration reloaded."<cr>')

-- Clear search buffer, clear command line and go to start of line
noremap('<leader>m', '<cmd>let @/=""<cr>:echo ""<cr>0<esc>', true)

-- Format file
noremap('<leader>;', 'gg=G')
