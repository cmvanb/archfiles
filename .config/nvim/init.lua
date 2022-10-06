--------------------------------------------------------------------------------
-- Neovim configuration
--------------------------------------------------------------------------------

-- Helpers
local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

--------------------------------------------------------------------------------
-- Settings
--------------------------------------------------------------------------------

-- Use terminal title
opt.title = true

-- NOTE: These should be the default values.
-- Syntax highlighting
-- cmd('filetype plugin on')
-- cmd('syntax on')

-- Show column and line info
opt.ruler = true

-- Show line numbers
opt.number = true

-- Highlight current line
opt.cursorline = true

-- Whitespace visualization
opt.listchars = { tab = '-->', eol = '⏎', trail = '·' }
opt.list = false

-- End-of-buffer visualization
opt.fillchars = { eob = ' ' }

-- Tabs should be 4 spaces
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Don't wrap lines
opt.wrap = false

-- File encoding
opt.fileencoding = 'utf-8'

-- Highlight search results
opt.hlsearch = true

-- Don't autoinsert comment leaders in normal mode
opt.formatoptions = opt.formatoptions - { 'o' }

-- Treat dash separated words as a whole word
opt.iskeyword = opt.iskeyword + { '-' }

-- Save swap file faster
opt.updatetime = 100

-- Set clipboard
opt.clipboard = 'unnamedplus'

-- Start scrolling this many lines before cursor reaches edge of window
opt.scrolloff = 0

-- Enable mouse in all modes
opt.mouse = 'a'

-- Folding
opt.foldmethod = 'syntax'
opt.foldenable = false

--------------------------------------------------------------------------------
-- Key bindings
--------------------------------------------------------------------------------

-- Helpers
function _map(mode, shortcut, command, silent)
    silent = silent or false
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = false, silent = silent })
end

function _noremap(mode, shortcut, command)
    silent = silent or false
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = silent })
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

-- TODO: Add additional map functions as needed.

-- Disable default bindings
noremap('q', '<Nop>')

-- Leader key
vim.g.mapleader = ' '

-- Visual block select
noremap('<leader>v', '<C-v>')

-- System clipboard
-- NOTE: This is only working (in TUI) because Wezterm is configured for it.
vnoremap('<C-c>', '"+y')
noremap('<C-v>', '"+p')

-- Fuzzy finder
noremap('<leader>o', '<cmd>Telescope find_files hidden=true no_ignore=true<cr>')
noremap('<leader>p', '<cmd>Telescope buffers<cr>')
noremap('<leader>g', '<cmd>Telescope live_grep<cr>')

-- Switch buffers
noremap('<leader>h', ':bprev<cr>')
noremap('<leader>l', ':bnext<cr>')

-- Close program without saving
noremap('<C-q>', ':qa!<cr>')

-- Close buffer
noremap('<leader>q', ':bd<cr>')

-- Close window
map('<C-w>c', '<Nop>')
noremap('<C-w>q', ':close<cr>')

-- Jump
noremap('<leader>f', '<cmd>HopWord<cr>')

-- Comment out selection (VISUAL) or current line (NORMAL)
-- NOTE: Does this need to be `map`?
map('<leader>/', 'gcc<esc>')

-- Reload vim configuration (this file)
noremap('<leader>r', '<cmd>source $MYVIMRC<bar>echo "Configuration reloaded. NOTE: Plugins may require restart, or `:PackerSync`."<cr>')

-- Clear search buffer, clear command line and go to start of line
noremap('<leader>m', '<cmd>let @/=""<cr>:echo ""<cr>0<esc>', true)

-- Format file
noremap('<leader>;', 'gg=G')

--------------------------------------------------------------------------------
-- Neovide (GUI) configuration
--------------------------------------------------------------------------------

if vim.g.neovide ~= nil then
    opt.guifont = 'Iosevka Nerd Font Mono:h12'

    -- TODO: Get Cursor highlighting working in Neovide.
    cmd('set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20') 

    vim.g.neovide_cursor_vfx_mode = 'sonicboom'
end

--------------------------------------------------------------------------------
-- Auto commands
--------------------------------------------------------------------------------

-- Reload configuration files automatically when edited. Also triggers package
-- manager compile step.
cmd([[
    augroup AutoReloadPlugins
        autocmd!
        autocmd BufWritePost init.lua source <afile>
        autocmd BufWritePost highlights.lua source <afile>
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

-- Always highlight TODOs and NOTEs
cmd([[
    augroup HighlightTodoNote
        autocmd!
        autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|NOTE', -1)
    augroup END
]])

--------------------------------------------------------------------------------
-- Configuration modules
--------------------------------------------------------------------------------

require('highlights')
require('plugins')

