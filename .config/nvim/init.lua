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

-- Edgemotion
noremap('<C-j>', '<Plug>(edgemotion-j)')
noremap('<C-k>', '<Plug>(edgemotion-k)')

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
-- Colors
--------------------------------------------------------------------------------

-- Import system colors
package.path = os.getenv('XDG_CONFIG_HOME') .. '/colors' .. [[/?.lua;]] .. package.path

local colors = require('lua-colors')
colors.parse_colors()

-- Use 24bit colors
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

function ln(group, target)
    cmd('hi! link ' .. group .. ' ' .. target)
end

-- User interface
-- TODO: Improve terminal color scheme.

-- group           . termfg . termbg . termprops        . guifg                     . guibg                      . guiprops
hi('Normal        ', '6    ', '0    ', 'NONE           ', colors.hash('ds_cyan_7')  , colors.hash('editor_bg')   , 'NONE           ')
hi('NonText       ', '4    ', 'NONE ', 'NONE           ', colors.hash('ds_cyan_4')  , 'NONE '                    , 'NONE           ')
hi('Cursor        ', '0    ', '7    ', 'NONE           ', colors.hash('black')      , colors.hash('white')       , 'NONE           ')
hi('CursorLine    ', 'NONE ', '0    ', 'NONE           ', 'NONE '                   , colors.hash('d4_purple')   , 'NONE           ')
hi('CursorLineNr  ', '7    ', '0    ', 'NONE           ', colors.hash('ds_cyan_6')  , colors.hash('d4_purple')   , 'NONE           ')
hi('LineNr        ', '8    ', 'NONE ', 'NONE           ', colors.hash('ds_cyan_4')  , 'NONE '                    , 'NONE           ')
hi('MatchParen    ', '7    ', 'NONE ', 'bold,underline ', colors.hash('white')      , 'NONE '                    , 'bold,underline ')
hi('Visual        ', '0    ', '13   ', 'NONE           ', colors.hash('black')      , colors.hash('l1_magenta')  , 'NONE           ')
hi('IncSearch     ', '0    ', '13   ', 'NONE           ', colors.hash('black')      , colors.hash('l1_green')    , 'bold           ')
hi('Search        ', '11   ', '2    ', 'bold           ', colors.hash('black')      , colors.hash('l1_magenta')  , 'bold           ')
hi('StatusLine    ', '7    ', '0    ', 'bold           ', colors.hash('ds_blue_9')  , colors.hash('ds_blue_3')   , 'bold           ')
hi('StatusLineNC  ', '8    ', '0    ', 'bold           ', colors.hash('ds_blue_5')  , colors.hash('ds_blue_1')   , 'NONE           ')
hi('TabLine       ', '7    ', '0    ', 'bold           ', colors.hash('ds_blue_5')  , colors.hash('ds_blue_1')   , 'bold           ')
hi('TabLineSel    ', '7    ', '0    ', 'bold           ', colors.hash('ds_blue_9')  , colors.hash('ds_blue_3')   , 'bold           ')
hi('TabLineFill   ', '7    ', '0    ', 'bold           ', 'NONE '                   , colors.hash('ds_blue_1')   , 'bold           ')
hi('Folded        ', '6    ', '0    ', 'bold           ', colors.hash('l3_purple')  , colors.hash('purple')      , 'NONE           ')
hi('MsgArea       ', '7    ', '4    ', 'bold           ', colors.hash('ds_blue_9')  , colors.hash('editor_bg')   , 'NONE           ')
hi('ErrorMsg      ', '9    ', '4    ', 'bold           ', colors.hash('l1_red')     , colors.hash('d4_red')      , 'bold           ')
hi('WarningMsg    ', '11   ', '4    ', 'bold           ', colors.hash('l1_yellow')  , colors.hash('d4_yellow')   , 'bold           ')
hi('MoreMsg       ', '7    ', '4    ', 'bold           ', colors.hash('l1_green')   , colors.hash('d4_green')    , 'bold           ')
hi('Title         ', '3    ', 'NONE ', 'bold           ', colors.hash('white')      , 'NONE '                    , 'bold           ')
hi('PMenu         ', '7    ', '8    ', 'NONE           ', colors.hash('white')      , colors.hash('d2_blue')     , 'NONE           ')
hi('PMenuSel      ', '7    ', '8    ', 'bold           ', colors.hash('l1_yellow')  , colors.hash('d2_blue')     , 'bold           ')
hi('VertSplit     ', '8    ', 'NONE ', 'NONE           ', colors.hash('gray')       , 'NONE '                    , 'NONE           ')

-- Links
ln('CursorColumn  ', 'CursorLine ')
ln('Question      ', 'MoreMsg    ')
ln('ModeMsg       ', 'MoreMsg    ')
ln('Error         ', 'ErrorMsg   ')
ln('healthSuccess ', 'MoreMsg   ')

-- Plugins
-- group                    . termfg . termbg . termprops        . guifg                    . guibg  . guiprops
hi('MiniCursorword         ', 'NONE ', 'NONE ', 'bold,underline ', 'NONE '                  , 'NONE ', 'bold,underline ')
hi('HopNextKey             ', '3    ', 'NONE ', 'bold           ', colors.hash('l1_purple') , 'NONE ', 'bold           ')
hi('HopNextKey1            ', '3    ', 'NONE ', 'bold           ', colors.hash('l1_purple') , 'NONE ', 'bold           ')
hi('HopNextKey2            ', '11   ', 'NONE ', 'bold           ', colors.hash('l2_purple') , 'NONE ', 'bold           ')
hi('TelescopeTitle         ', '12   ', 'NONE ', 'bold           ', colors.hash('white')     , 'NONE ', 'bold           ')
hi('TelescopeBorder        ', '4    ', 'NONE ', 'bold           ', colors.hash('ds_blue_5') , 'NONE ', 'bold           ')
hi('TelescopeMatching      ', '11   ', 'NONE ', 'bold           ', colors.hash('yellow')    , 'NONE ', 'bold           ')

-- Links
ln('TelescopePromptCounter ', 'TelescopeTitle ')
ln('MiniIndentscopeSymbol  ', 'NonText ')

-- Syntax highlighting
-- group             . termfg . termbg . termprops        . guifg                     . guibg  . guiprops
hi('Identifier      ', '7    ', 'NONE ', 'NONE           ', colors.hash('white')      , 'NONE ', 'NONE           ')
hi('Statement       ', '10   ', 'NONE ', 'bold           ', colors.hash('ds_green_7') , 'NONE ', 'bold           ')
hi('Comment         ', '8    ', 'NONE ', 'NONE           ', colors.hash('ds_cyan_4')  , 'NONE ', 'italic         ')
hi('Type            ', '3    ', 'NONE ', 'NONE           ', colors.hash('l1_purple')  , 'NONE ', 'NONE           ')
hi('PreProc         ', '11   ', 'NONE ', 'NONE           ', colors.hash('l1_yellow')  , 'NONE ', 'NONE           ')
hi('Constant        ', '13   ', 'NONE ', 'NONE           ', colors.hash('l1_magenta') , 'NONE ', 'NONE           ')
hi('Special         ', '14   ', 'NONE ', 'NONE           ', colors.hash('yellow')     , 'NONE ', 'bold           ')
hi('Underlined      ', '4    ', 'NONE ', 'underline      ', colors.hash('blue')       , 'NONE ', 'underline      ')
hi('Delimiter       ', '4    ', 'NONE ', 'NONE           ', colors.hash('ds_green_5') , 'NONE ', 'NONE           ')
hi('String          ', '2    ', 'NONE ', 'NONE           ', colors.hash('l1_orange')  , 'NONE ', 'NONE           ')
hi('Keyword         ', '10   ', 'NONE ', 'bold           ', colors.hash('ds_green_7') , 'NONE ', 'bold           ')
hi('Todo            ', '7    ', 'NONE ', 'bold,underline ', colors.hash('l1_white')   , 'NONE ', 'bold,underline ')
hi('Function        ', '13   ', 'NONE ', 'bold           ', colors.hash('ds_cyan_9')  , 'NONE ', 'bold           ')
hi('Number          ', '9    ', 'NONE ', 'NONE           ', colors.hash('l1_red')     , 'NONE ', 'NONE           ')
hi('Boolean         ', '9    ', 'NONE ', 'NONE           ', colors.hash('red')        , 'NONE ', 'NONE           ')
hi('Ignore          ', '0    ', 'NONE ', 'NONE           ', colors.hash('d3_gray')    , 'NONE ', 'bold           ')

-- Links
ln('vimCommentTitle ', 'Comment    ')
ln('vimOption       ', 'Identifier ')
ln('Operator        ', 'Keyword    ')

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

