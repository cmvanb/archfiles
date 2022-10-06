--------------------------------------------------------------------------------
-- Colors
--------------------------------------------------------------------------------

-- Helpers
--------------------------------------------------------------------------------
local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

function hi(group, guifg, guibg, guiprops, termfg, termbg, termprops)
    cmd('hi ' .. group .. ' guifg=' .. guifg .. ' guibg=' .. guibg .. ' gui=' .. guiprops .. ' ctermfg=' .. termfg .. ' ctermbg=' .. termbg .. ' cterm=' .. termprops)
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

-- Import system colors
--------------------------------------------------------------------------------
 
package.path = os.getenv('XDG_CONFIG_HOME') .. '/colors' .. [[/?.lua;]] .. package.path

local colors = require('lua-colors')
colors.parse_colors()

-- Configure highlights
-- TODO: Improve terminal color scheme.
--------------------------------------------------------------------------------

-- User interface
-- group            | guifg                    | guibg                    | guiprops | termfg | termbg | termprops        
hi('Normal',        colors.hash('ds_cyan_7'),  colors.hash('editor_bg'),  'NONE',    '6',     '0',     'NONE')
hi('NonText',       colors.hash('white'),      'NONE',                    'NONE',    '4',     'NONE',  'NONE')
hi('EndOfBuffer',   'NONE',                    'NONE',                    'NONE',    '4',     'NONE',  'NONE')
hi('Cursor',        colors.hash('black'),      colors.hash('white'),      'NONE',    '0',     '7',     'NONE')
hi('CursorLine',    'NONE',                    colors.hash('d4_purple'),  'NONE',    'NONE',  '0',     'NONE')
hi('CursorLineNr',  colors.hash('ds_cyan_6'),  colors.hash('d4_purple'),  'NONE',    '7',     '0',     'NONE')
hi('LineNr',        colors.hash('ds_cyan_4'),  'NONE',                    'NONE',    '8',     'NONE',  'NONE')
hi('SignColumn',    colors.hash('ds_cyan_4'),  colors.hash('editor_bg'),  'NONE',    '7',     '0',     'NONE')
hi('Visual',        colors.hash('black'),      colors.hash('magenta'),    'NONE',    '0',     '13',    'NONE')
hi('IncSearch',     colors.hash('black'),      colors.hash('green'),      'bold',    '0',     '13',    'NONE')
hi('Search',        colors.hash('black'),      colors.hash('cyan'),       'bold',    '11',    '2',     'bold')
hi('StatusLine',    colors.hash('ds_blue_9'),  colors.hash('ds_blue_3'),  'bold',    '7',     '0',     'bold')
hi('StatusLineNC',  colors.hash('ds_blue_5'),  colors.hash('ds_blue_1'),  'NONE',    '8',     '0',     'bold')
hi('TabLine',       colors.hash('ds_blue_5'),  colors.hash('ds_blue_1'),  'bold',    '7',     '0',     'bold')
hi('TabLineSel',    colors.hash('ds_blue_9'),  colors.hash('ds_blue_3'),  'bold',    '7',     '0',     'bold')
hi('TabLineFill',   'NONE',                    colors.hash('ds_blue_1'),  'bold',    '7',     '0',     'bold')
hi('Folded',        colors.hash('l3_purple'),  colors.hash('purple'),     'NONE',    '6',     '0',     'bold')
hi('MsgArea',       colors.hash('ds_blue_9'),  colors.hash('editor_bg'),  'NONE',    '7',     '4',     'bold')
hi('ErrorMsg',      colors.hash('l1_red'),     colors.hash('d4_red'),     'bold',    '9',     '4',     'bold')
hi('WarningMsg',    colors.hash('l1_yellow'),  colors.hash('d4_yellow'),  'bold',    '11',    '4',     'bold')
hi('MoreMsg',       colors.hash('l1_green'),   colors.hash('d4_green'),   'bold',    '7',     '4',     'bold')
hi('Title',         colors.hash('white'),      'NONE',                    'bold',    '3',     'NONE',  'bold')
hi('PMenu',         colors.hash('white'),      colors.hash('editor_bg'),  'NONE',    '7',     '8',     'NONE')
hi('PMenuSel',      colors.hash('l1_yellow'),  colors.hash('ds_blue_5'),  'bold',    '7',     '8',     'bold')
hi('WinSeparator',  colors.hash('ds_blue_3'),  'NONE',                    'NONE',    '8',     'NONE',  'NONE')
hi('MatchParen',    colors.hash('white'),      'NONE',                    'bold',    '7',     'NONE',  'bold,underline')

-- Links
-- src               | dest
ln('CursorColumn',   'CursorLine')
ln('Question',       'MoreMsg')
ln('ModeMsg',        'MoreMsg')
ln('Error',          'ErrorMsg')
ln('healthSuccess',  'MoreMsg')
ln('VertSplit',      'WinSeparator')
ln('Whitespace',     'NonText')

-- Custom defined UI
-- group              | guifg                    | guibg                    | guiprops | termfg | termbg | termprops 
hi('CMenuNormal',     colors.hash('ds_blue_9'),  colors.hash('ds_blue_1'),  'bold',    '0',     '8',     'NONE')
hi('CMenuSelection',  colors.hash('white'),      colors.hash('ds_blue_5'),  'bold',    '2',     '15',    'bold')
hi('CMenuItem',       colors.hash('ds_blue_9'),  'NONE',                    'NONE',    '15',    'NONE',  'NONE')
hi('CMenuItemMatch',  colors.hash('l1_yellow'),  'NONE',                    'NONE',    '11',    'NONE',  'NONE')

-- Plugins
-- group                     | guifg                    | guibg  | guiprops         | termfg | termbg | termprops        
hi('HopNextKey',             colors.hash('l1_purple'),  'NONE',  'bold',            '3',     'NONE',  'bold')
hi('HopNextKey1',            colors.hash('l1_purple'),  'NONE',  'bold',            '3',     'NONE',  'bold')
hi('HopNextKey2',            colors.hash('l2_purple'),  'NONE',  'bold',            '11',    'NONE',  'bold')
hi('MiniCursorword',         'NONE',                    'NONE',  'bold,underline',  'NONE',  'NONE',  'bold,underline')
hi('MiniIndentscopeSymbol',  colors.hash('ds_cyan_3'),  'NONE',  'NONE',            '6',     'NONE',  'NONE')          

-- Links
-- src                        | dest
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

-- Syntax highlighting
-- group          | guifg                     | guibg  | guiprops         | termfg  | termbg | termprops        
hi('Identifier',  colors.hash('white'),       'NONE',  'NONE',            '7',      'NONE',  'NONE')
hi('Statement',   colors.hash('ds_green_7'),  'NONE',  'bold',            '10',     'NONE',  'bold')
hi('Comment',     colors.hash('ds_cyan_4'),   'NONE',  'italic',          '8',      'NONE',  'NONE')
hi('Type',        colors.hash('l1_purple'),   'NONE',  'NONE',            '3',      'NONE',  'NONE')
hi('PreProc',     colors.hash('l1_yellow'),   'NONE',  'NONE',            '11',     'NONE',  'NONE')
hi('Constant',    colors.hash('l1_magenta'),  'NONE',  'NONE',            '13',     'NONE',  'NONE')
hi('Special',     colors.hash('yellow'),      'NONE',  'bold',            '14',     'NONE',  'NONE')
hi('Underlined',  colors.hash('blue'),        'NONE',  'underline',       '4',      'NONE',  'underline')
hi('Delimiter',   colors.hash('ds_green_5'),  'NONE',  'NONE',            '4',      'NONE',  'NONE')
hi('String',      colors.hash('l1_orange'),   'NONE',  'NONE',            '2',      'NONE',  'NONE')
hi('Keyword',     colors.hash('ds_green_7'),  'NONE',  'bold',            '10',     'NONE',  'bold')
hi('Todo',        colors.hash('l1_white'),    'NONE',  'bold,underline',  '7',      'NONE',  'bold,underline')
hi('Function',    colors.hash('ds_cyan_9'),   'NONE',  'bold',            '13',     'NONE',  'bold')
hi('Number',      colors.hash('l1_red'),      'NONE',  'NONE',            '9',      'NONE',  'NONE')
hi('Boolean',     colors.hash('red'),         'NONE',  'NONE',            '9',      'NONE',  'NONE')
hi('Ignore',      colors.hash('d3_gray'),     'NONE',  'bold',            '0',      'NONE',  'NONE')

-- Links
-- src                 | dest
ln('vimCommentTitle',  'Comment')
ln('vimOption',        'Identifier')
ln('Operator',         'Keyword')

-- Special highlights
--------------------------------------------------------------------------------

-- TODO: Sort this out in Lua

-- function highlightNotes
--     cmd([[
--         syn match Notes /\%(NOTE:\)/
--         hi link Notes Todo
--     ]])
-- end
--
-- -- Add highlighting for NOTEs
-- cmd([[
--     augroup HighlightNotes
--         autocmd!
--         autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|NOTE', -1)
--     augroup END
-- ]])

