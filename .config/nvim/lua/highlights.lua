--------------------------------------------------------------------------------
-- Colors
--------------------------------------------------------------------------------

-- Import system colors
--------------------------------------------------------------------------------

package.path = os.getenv('XDG_CONFIG_HOME') .. '/colors' .. [[/?.lua;]] .. package.path

local colors = require('lua-colors')
colors.parse_colors()

-- Helpers
--------------------------------------------------------------------------------

local cmd = vim.cmd
local opt = vim.opt
local api = vim.api
local fn = vim.fn
local g = vim.g

function hi(group, guifg, guibg, guiprops, termfg, termbg, termprops)
    if guifg ~= 'NONE' then
        guifg = colors.hash(guifg)
    end
    if guibg ~= 'NONE' then
        guibg = colors.hash(guibg)
    end
    if termfg ~= 'NONE' then
        termfg = colors.name_to_ansi_index(termfg)
    end
    if termbg ~= 'NONE' then
        termbg = colors.name_to_ansi_index(termbg)
    end

    cmd('hi! ' .. group ..
        ' guifg=' .. guifg ..
        ' guibg=' .. guibg ..
        ' gui=' .. guiprops ..
        ' ctermfg=' .. termfg ..
        ' ctermbg=' .. termbg ..
        ' cterm=' .. termprops)
end

function ln(group, target)
    cmd('hi! link ' .. group .. ' ' .. target)
end

-- Settings
--------------------------------------------------------------------------------

-- Use 24bit colors
opt.termguicolors = true

-- Reset any pre-existing syntax highlighting
cmd('syntax reset')

-- NVIM UI highlights
--------------------------------------------------------------------------------

-- group            | guifg       | guibg       | guiprops | termfg          | termbg           | termprops
hi('Normal',        'ds_cyan_7',  'editor_bg',  'NONE',    'ansi_cyan',      'ansi_black',      'NONE')
hi('NonText',       'white',      'NONE',       'NONE',    'ansi_brwhite',   'NONE',            'NONE')
hi('EndOfBuffer',   'NONE',       'NONE',       'NONE',    'NONE',           'NONE',            'NONE')
hi('Cursor',        'black',      'white',      'NONE',    'ansi_black',     'ansi_white',      'NONE')
hi('CursorLine',    'NONE',       'd4_purple',  'NONE',    'NONE',           'ansi_brblack',    'bold')
hi('CursorLineNr',  'ds_cyan_6',  'd4_purple',  'NONE',    'ansi_cyan',      'ansi_black',      'NONE')
hi('LineNr',        'ds_cyan_4',  'NONE',       'NONE',    'ansi_brblack',   'NONE',            'NONE')
hi('SignColumn',    'ds_cyan_4',  'editor_bg',  'NONE',    'ansi_white',     'ansi_black',      'NONE')
hi('Visual',        'black',      'magenta',    'NONE',    'ansi_black',     'ansi_brmagenta',  'NONE')
hi('IncSearch',     'black',      'green',      'bold',    'ansi_black',     'ansi_brgreen',    'NONE')
hi('Search',        'black',      'cyan',       'bold',    'ansi_black',     'ansi_brcyan',     'NONE')
hi('StatusLine',    'ds_blue_9',  'ds_blue_3',  'bold',    'ansi_white',     'ansi_blue',       'bold')
hi('StatusLineNC',  'ds_blue_5',  'ds_blue_1',  'NONE',    'ansi_brblack',   'ansi_black',      'bold')
hi('TabLine',       'ds_blue_5',  'ds_blue_1',  'bold',    'ansi_white',     'ansi_blue',       'NONE')
hi('TabLineSel',    'ds_blue_9',  'ds_blue_3',  'bold',    'ansi_white',     'ansi_blue',       'bold')
hi('TabLineFill',   'NONE',       'ds_blue_1',  'bold',    'ansi_white',     'ansi_blue',       'bold')
hi('Folded',        'l3_purple',  'purple',     'NONE',    'ansi_cyan',      'ansi_black',      'bold')
hi('MsgArea',       'ds_blue_9',  'editor_bg',  'NONE',    'ansi_white',     'ansi_brblack',    'NONE')
hi('ErrorMsg',      'l1_red',     'd4_red',     'bold',    'ansi_brred',     'ansi_red',        'bold')
hi('WarningMsg',    'l1_yellow',  'd2_orange',  'bold',    'ansi_bryellow',  'ansi_yellow',     'bold')
hi('MoreMsg',       'l1_green',   'd4_green',   'bold',    'ansi_brgreen',   'ansi_green',      'bold')
hi('Title',         'white',      'NONE',       'bold',    'ansi_brwhite',   'NONE',            'bold')
hi('PMenu',         'white',      'editor_bg',  'NONE',    'ansi_white',     'ansi_black',      'NONE')
hi('PMenuSel',      'l1_yellow',  'ds_blue_5',  'bold',    'ansi_white',     'ansi_black',      'bold')
hi('WinSeparator',  'ds_blue_3',  'NONE',       'NONE',    'ansi_brblack',   'NONE',            'NONE')
hi('MatchParen',    'white',      'NONE',       'bold',    'ansi_brwhite',   'NONE',            'bold,underline')

-- group             | target
ln('CursorColumn',   'CursorLine')
ln('Question',       'MoreMsg')
ln('ModeMsg',        'MoreMsg')
ln('Error',          'ErrorMsg')
ln('healthSuccess',  'MoreMsg')
ln('VertSplit',      'WinSeparator')
ln('Whitespace',     'NonText')

-- Custom UI highlights
--------------------------------------------------------------------------------

-- group              | guifg       | guibg       | guiprops | termfg          | termbg       | termprops
hi('CMenuNormal',     'ds_blue_9',  'ds_blue_1',  'bold',    'ansi_cyan',      'ansi_blue',   'NONE')
hi('CMenuSelection',  'white',      'ds_blue_5',  'bold',    'ansi_brwhite',   'ansi_black',  'bold')
hi('CMenuItem',       'ds_blue_9',  'NONE',       'NONE',    'ansi_brblue',    'NONE',        'NONE')
hi('CMenuItemMatch',  'l1_yellow',  'NONE',       'NONE',    'ansi_bryellow',  'NONE',        'NONE')

-- Plugin highlights
--------------------------------------------------------------------------------

-- group                     | guifg       | guibg  | guiprops         | termfg           | termbg | termprops
hi('HopNextKey',             'l1_purple',  'NONE',  'bold',            'ansi_magenta',    'NONE',  'NONE')
hi('HopNextKey1',            'l1_purple',  'NONE',  'bold',            'ansi_magenta',    'NONE',  'NONE')
hi('HopNextKey2',            'l2_purple',  'NONE',  'bold',            'ansi_brmagenta',  'NONE',  'bold')
hi('MiniCursorword',         'NONE',       'NONE',  'bold,underline',  'NONE',            'NONE',  'bold,underline')
hi('MiniIndentscopeSymbol',  'ds_cyan_3',  'NONE',  'NONE',            'ansi_brblack',    'NONE',  'NONE')

-- group                      | target
ln('CmpMenuBackground',       'CMenuNormal')     
ln('CmpMenuSelect',           'CMenuSelection')  
ln('CmpItemAbbr',             'CMenuItem')       
ln('CmpItemAbbrMatch',        'CMenuItemMatch')  
ln('CmpItemKind',             'Type')            
ln('TelescopeNormal',         'Normal')          
ln('TelescopeBorder',         'WinSeparator')    
ln('TelescopeTitle',          'Title')           
ln('TelescopePromptCounter',  'TelescopeTitle')  
ln('TelescopeMatching',       'CMenuItemMatch')  
ln('TelescopeSelection',      'CMenuSelection')  

-- Syntax highlights
--------------------------------------------------------------------------------

-- group          | guifg        | guibg  | guiprops         | termfg           | termbg | termprops
hi('Identifier',  'white',       'NONE',  'NONE',            'ansi_white',      'NONE',  'NONE')
hi('Statement',   'ds_green_7',  'NONE',  'bold',            'ansi_brgreen',    'NONE',  'bold')
hi('Comment',     'ds_cyan_4',   'NONE',  'italic',          'ansi_brblack',    'NONE',  'NONE')
hi('Type',        'l1_purple',   'NONE',  'NONE',            'ansi_magenta',    'NONE',  'NONE')
hi('PreProc',     'l1_yellow',   'NONE',  'NONE',            'ansi_bryellow',   'NONE',  'NONE')
hi('Constant',    'l1_magenta',  'NONE',  'NONE',            'ansi_brmagenta',  'NONE',  'NONE')
hi('Special',     'yellow',      'NONE',  'bold',            'ansi_yellow',     'NONE',  'NONE')
hi('Underlined',  'blue',        'NONE',  'underline',       'ansi_blue',       'NONE',  'underline')
hi('Delimiter',   'ds_green_5',  'NONE',  'NONE',            'ansi_green',      'NONE',  'NONE')
hi('String',      'l1_orange',   'NONE',  'NONE',            'ansi_yellow',     'NONE',  'NONE')
hi('Keyword',     'ds_green_7',  'NONE',  'bold',            'ansi_brgreen',    'NONE',  'bold')
hi('Function',    'ds_cyan_9',   'NONE',  'bold',            'ansi_brcyan',     'NONE',  'bold')
hi('Number',      'l1_red',      'NONE',  'NONE',            'ansi_brred',      'NONE',  'NONE')
hi('Boolean',     'red',         'NONE',  'NONE',            'ansi_red',        'NONE',  'NONE')
hi('Ignore',      'd3_gray',     'NONE',  'bold',            'ansi_brblack',    'NONE',  'NONE')
hi('Todo',        'ds_cyan_9',   'NONE',  'bold,nocombine',  'ansi_brwhite',    'NONE',  'bold')

-- group               | target
ln('vimCommentTitle',  'Comment')
ln('vimOption',        'Identifier')
ln('Operator',         'Keyword')

-- Special snowflakes
--------------------------------------------------------------------------------

-- Show notes in all files, just like todos.
api.nvim_create_augroup('HighlightNotes', { clear = true })
api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
    group = 'HighlightNotes',
    callback = function()
        fn.matchadd('Todo', 'TODO:\\|NOTE:')
    end,
})

