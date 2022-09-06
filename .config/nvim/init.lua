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

-- Syntax highlighting
cmd('filetype plugin on')
cmd('syntax on')

-- Show column and line info
opt.ruler = true

-- Show line numbers
opt.number = true

-- Highlight current line
opt.cursorline = true

-- Whitespace visualization
opt.listchars = { tab = '→-', eol = '↓', trail = '⌂' }
opt.list = false

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
opt.updatetime = 400

-- Set clipboard
opt.clipboard = 'unnamedplus'

-- Start scrolling this many lines before cursor reaches edge of window
opt.scrolloff = 3

-- Enable mouse in all modes
opt.mouse = 'a'

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
noremap('<leader>f', '<cmd>Telescope live_grep<cr>')

-- Switch buffers
noremap('<leader>h', ':bprev<cr>')
noremap('<leader>l', ':bnext<cr>')

-- Close buffer
noremap('<leader>q', ':bd<cr>')

-- Hop (motion shortcuts)
noremap('<leader>g', '<cmd>HopWord<cr>')

-- Comment out selection (VISUAL) or current line (NORMAL)
-- NOTE: Does this need to be `map`?
map('<leader>/', 'gcc<esc>')

-- Reload vim configuration (this file)
noremap('<leader>r', '<cmd>source $MYVIMRC<bar>echo "Configuration reloaded. NOTE: Plugins may require restart, or `:PackerSync`."<cr>')

-- Clear search buffer, clear command line and go to start of line
noremap('<leader>m', '<cmd>let @/=""<bar>:echo ""<cr>0<esc>', true)

-- Format file
noremap('<leader>;', 'gg=G')

-- Edgemotion
noremap('<C-j>', '<Plug>(edgemotion-j)')
noremap('<C-k>', '<Plug>(edgemotion-k)')

--------------------------------------------------------------------------------
-- Neovide (GUI) configuration
--------------------------------------------------------------------------------

if vim.g.neovide ~= nil then
    opt.guifont = 'Fira Code:h11'

    -- TODO: Get Cursor highlighting working in Neovide.
    cmd('set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20') 

    vim.g.neovide_cursor_vfx_mode = 'sonicboom'
end

--------------------------------------------------------------------------------
-- Colors
--------------------------------------------------------------------------------

-- Import system colors
package.path = os.getenv('XDG_CONFIG_HOME') .. '/colors' .. [[/?.lua]]

local colors = require('lua-colors')
colors.parse_colors()

-- TODO: Use 24bit colors: `set termguicolors`
-- TODO: Apply system color scheme

-- Use base 16 colors
opt.termguicolors = true

-- NOTE: Is this doing anything?
-- Let vim know we are using a dark background color
opt.background = dark

-- Reset any pre-existing syntax highlighting
cmd('syntax reset')

-- Helper functions
function hi(group, termfg, termbg, termprops, guifg, guibg, guiprops)
    cmd('hi ' .. group .. ' ctermfg=' .. termfg .. ' ctermbg=' .. termbg .. ' cterm=' .. termprops .. ' guifg=' .. guifg .. ' guibg=' .. guibg .. ' gui=' .. guiprops)
end

function hi_link(group, target)
    cmd('hi! link ' .. group .. ' ' .. target)
end

-- Vim highlighting
-- GROUP          . TERMFG . TERMBG . TERMPROPS        . GUIFG                     . GUIBG                      . GUIPROPS ---------
hi('Normal       ', '6    ', '0    ', 'NONE           ', colors.named('cyan')      , colors.named('black')      , 'NONE           ')
hi('NonText      ', '6    ', 'NONE ', 'NONE           ', colors.named('cyan')      , 'NONE '                    , 'NONE           ')
hi('Cursor       ', '0    ', '7    ', 'NONE           ', colors.named('black')     , colors.named('white')      , 'NONE           ')
hi('CursorLine   ', 'NONE ', '0    ', 'NONE           ', 'NONE '                   , colors.named('d2_blue')    , 'NONE           ')
hi('MatchParen   ', '7    ', 'NONE ', 'bold,underline ', colors.named('white')     , 'NONE '                    , 'bold,underline ')
hi('NonText      ', '4    ', 'NONE ', 'NONE           ', colors.named('blue')      , 'NONE '                    , 'NONE           ')
hi('LineNr       ', '8    ', 'NONE ', 'NONE           ', colors.named('gray')      , 'NONE '                    , 'NONE           ')
hi('CursorLineNr ', '7    ', '0    ', 'NONE           ', colors.named('white')     , colors.named('black')      , 'NONE           ')
hi('Visual       ', '0    ', '13   ', 'NONE           ', colors.named('white')     , colors.named('d2_magenta') , 'bold           ')
hi('IncSearch    ', '0    ', '13   ', 'NONE           ', colors.named('magenta')   , colors.named('white')      , 'bold           ')
hi('Search       ', '11   ', '2    ', 'bold           ', colors.named('white')     , colors.named('magenta')    , 'bold           ')
hi('StatusLine   ', '7    ', '0    ', 'bold           ', colors.named('white')     , colors.named('black')      , 'bold           ')
hi('StatusLineNC ', '8    ', '0    ', 'bold           ', colors.named('gray')      , colors.named('black')      , 'bold           ')
hi('Folded       ', '6    ', '0    ', 'bold           ', colors.named('cyan')      , colors.named('black')      , 'bold           ')
hi('ErrorMsg     ', '11   ', '1    ', 'bold           ', colors.named('yellow')    , colors.named('red')        , 'bold           ')
hi('Title        ', '3    ', 'NONE ', 'bold           ', colors.named('yellow')    , 'NONE '                    , 'bold           ')
hi('VertSplit    ', '8    ', 'NONE ', 'NONE           ', colors.named('gray')      , 'NONE '                    , 'NONE           ')

-- Links
------- GROUP             . TARGET -------
hi_link('vimCommentTitle ', 'Comment    ')
hi_link('vimOption       ', 'Identifier ')
hi_link('CursorColumn    ', 'CursorLine ')
hi_link('WarningMsg      ', 'ErrorMsg   ')
hi_link('MoreMsg         ', 'Title      ')
hi_link('Question        ', 'MoreMsg    ')
hi_link('ModeMsg         ', 'MoreMsg    ')

-- Generic code highlighting
-- GROUP        . TERMFG . TERMBG . TERMPROPS        . GUIFG                      . GUIBG  . GUIPROPS ---------
hi('Identifier ', '7    ', 'NONE ', 'NONE           ', colors.named('white')      , 'NONE ', 'NONE           ')
hi('Statement  ', '10   ', 'NONE ', 'bold           ', colors.named('l1_green')   , 'NONE ', 'bold           ')
hi('Comment    ', '8    ', 'NONE ', 'NONE           ', colors.named('l1_gray')    , 'NONE ', 'NONE           ')
hi('Type       ', '3    ', 'NONE ', 'NONE           ', colors.named('yellow')     , 'NONE ', 'NONE           ')
hi('PreProc    ', '11   ', 'NONE ', 'NONE           ', colors.named('l1_yellow')  , 'NONE ', 'NONE           ')
hi('Constant   ', '13   ', 'NONE ', 'NONE           ', colors.named('l1_magenta') , 'NONE ', 'NONE           ')
hi('Special    ', '15   ', 'NONE ', 'NONE           ', colors.named('l1_white')   , 'NONE ', 'NONE           ')
hi('Underlined ', '4    ', 'NONE ', 'underline      ', colors.named('blue')       , 'NONE ', 'underline      ')
hi('Delimiter  ', '4    ', 'NONE ', 'NONE           ', colors.named('blue')       , 'NONE ', 'NONE           ')
hi('String     ', '2    ', 'NONE ', 'NONE           ', colors.named('green')      , 'NONE ', 'NONE           ')
hi('Keyword    ', '10   ', 'NONE ', 'bold           ', colors.named('l1_green')   , 'NONE ', 'bold           ')
hi('Todo       ', '7    ', 'NONE ', 'bold,underline ', colors.named('white')      , 'NONE ', 'bold,underline ')
hi('Function   ', '13   ', 'NONE ', 'NONE           ', colors.named('l1_magenta') , 'NONE ', 'NONE           ')
hi('Number     ', '9    ', 'NONE ', 'NONE           ', colors.named('l1_red')     , 'NONE ', 'NONE           ')
hi('Boolean    ', '9    ', 'NONE ', 'NONE           ', colors.named('l1_red')     , 'NONE ', 'NONE           ')
hi('Ignore     ', '0    ', 'NONE ', 'NONE           ', colors.named('gray')       , 'NONE ', 'NONE           ')

-- Links
------- GROUP      . TARGET ------
hi_link('Error    ', 'ErrorMsg  ')
hi_link('Operator ', 'Delimiter ')

--------------------------------------------------------------------------------
-- Auto commands
--------------------------------------------------------------------------------

-- Reload vim configuration automatically when edited
cmd('au! bufwritepost $MYVIMRC source $MYVIMRC')

-- Always highlight TODOs and NOTEs
cmd([[
    augroup HighlightTodoNote
        autocmd!
        autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|NOTE', -1)
    augroup END
    ]])

--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------

require('plugins')

