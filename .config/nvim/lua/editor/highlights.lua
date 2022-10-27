--------------------------------------------------------------------------------
-- Neovim highlights
--------------------------------------------------------------------------------

-- Retrieve system colors
--------------------------------------------------------------------------------

local colors_path = os.getenv('XDG_CONFIG_HOME') .. [[/colors/?.lua;]]
local PathUtils = require('utils.path')

PathUtils.prepend_to_package_path(colors_path)

local Colors = require('lua-colors')

Colors.parse_colors()

-- TODO: Extract utility.
-- Helpers
--------------------------------------------------------------------------------

local cmd = vim.cmd
local opt = vim.opt

local function hi(group, guifg, guibg, guiprops, termfg, termbg, termprops)
    if guifg ~= 'NONE' then
        guifg = Colors.hash(guifg)
    end
    if guibg ~= 'NONE' then
        guibg = Colors.hash(guibg)
    end
    if termfg ~= 'NONE' then
        termfg = Colors.name_to_ansi_index(termfg)
    end
    if termbg ~= 'NONE' then
        termbg = Colors.name_to_ansi_index(termbg)
    end

    cmd('hi! ' .. group ..
        ' guifg=' .. guifg ..
        ' guibg=' .. guibg ..
        ' gui=' .. guiprops ..
        ' ctermfg=' .. termfg ..
        ' ctermbg=' .. termbg ..
        ' cterm=' .. termprops)
end

local function ln(group, target)
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
hi('EndOfBuffer',   'ds_cyan_4',  'NONE',       'NONE',    'NONE',           'NONE',            'NONE')
hi('Cursor',        'black',      'white',      'NONE',    'ansi_black',     'ansi_white',      'NONE')
hi('CursorLine',    'NONE',       'ds_blue_1',  'NONE',    'NONE',           'ansi_brblack',    'bold')
hi('CursorLineNr',  'ds_cyan_6',  'ds_blue_1',  'NONE',    'ansi_cyan',      'ansi_black',      'NONE')
hi('LineNr',        'ds_cyan_4',  'NONE',       'NONE',    'ansi_brblack',   'NONE',            'NONE')
hi('SignColumn',    'ds_cyan_4',  'editor_bg',  'NONE',    'ansi_white',     'ansi_black',      'NONE')
hi('Visual',        'black',      'magenta',    'NONE',    'ansi_black',     'ansi_brmagenta',  'NONE')
hi('IncSearch',     'black',      'green',      'bold',    'ansi_black',     'ansi_brgreen',    'NONE')
hi('Search',        'black',      'cyan',       'bold',    'ansi_black',     'ansi_brcyan',     'NONE')
hi('StatusLine',    'ds_blue_8',  'ds_blue_5',  'bold',    'ansi_white',     'ansi_blue',       'bold')
hi('StatusLineNC',  'ds_blue_5',  'ds_blue_1',  'NONE',    'ansi_brblack',   'ansi_black',      'NONE')
hi('TabLine',       'ds_blue_5',  'ds_blue_1',  'bold',    'ansi_white',     'ansi_blue',       'NONE')
hi('TabLineSel',    'ds_blue_8',  'ds_blue_3',  'bold',    'ansi_white',     'ansi_blue',       'bold')
hi('TabLineFill',   'NONE',       'ds_blue_1',  'bold',    'ansi_white',     'ansi_blue',       'bold')
hi('Folded',        'l3_purple',  'purple',     'NONE',    'ansi_cyan',      'ansi_black',      'bold')
hi('MsgArea',       'ds_blue_8',  'editor_bg',  'NONE',    'ansi_white',     'ansi_brblack',    'NONE')
hi('ErrorMsg',      'l1_red',     'd4_red',     'bold',    'ansi_brred',     'ansi_red',        'bold')
hi('WarningMsg',    'l1_yellow',  'd2_orange',  'bold',    'ansi_bryellow',  'ansi_yellow',     'bold')
hi('MoreMsg',       'l1_white',   'gray',       'bold',    'ansi_brgreen',   'ansi_green',      'bold')
hi('Title',         'white',      'NONE',       'bold',    'ansi_brwhite',   'NONE',            'bold')
hi('PMenu',         'white',      'editor_bg',  'NONE',    'ansi_white',     'ansi_black',      'NONE')
hi('PMenuSel',      'l1_yellow',  'ds_blue_5',  'bold',    'ansi_white',     'ansi_black',      'bold')
hi('WinSeparator',  'ds_blue_3',  'NONE',       'NONE',    'ansi_brblack',   'NONE',            'NONE')
hi('MatchParen',    'white',      'NONE',       'bold',    'ansi_brwhite',   'NONE',            'bold,underline')
hi('DiffAdd',       'green',      'NONE',       'bold',    'ansi_green',     'NONE',            'NONE')
hi('DiffChange',    'yellow',     'NONE',       'bold',    'ansi_yellow',    'NONE',            'NONE')
hi('DiffDelete',    'red',        'NONE',       'bold',    'ansi_red',       'NONE',            'NONE')

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

-- group                  | guifg       | guibg       | guiprops | termfg          | termbg       | termprops
hi('CMenuNormal',         'ds_blue_9',  'ds_blue_1',  'NONE',    'ansi_cyan',      'ansi_blue',   'NONE')
hi('CMenuSelection',      'white',      'ds_blue_5',  'bold',    'ansi_brwhite',   'ansi_black',  'bold')
hi('CMenuItem',           'ds_blue_9',  'NONE',       'NONE',    'ansi_brblue',    'NONE',        'NONE')
hi('CMenuItemMatch',      'l1_yellow',  'NONE',       'bold',    'ansi_bryellow',  'NONE',        'NONE')
hi('FloatMenuNormal',     'ds_blue_8',  'editor_bg',  'NONE',    'ansi_cyan',      'ansi_blue',   'NONE')
hi('FloatMenuSelection',  'white',      'ds_blue_5',  'bold',    'ansi_brwhite',   'ansi_black',  'bold')
hi('FloatMenuItem',       'ds_blue_8',  'NONE',       'NONE',    'ansi_cyan',      'ansi_blue',   'NONE')
hi('FloatMenuItemMatch',  'l1_yellow',  'NONE',       'bold',    'ansi_cyan',      'ansi_blue',   'NONE')

-- Plugin highlights
--------------------------------------------------------------------------------
-- group                     | guifg       | guibg       | guiprops         | termfg           | termbg | termprops
hi('LeapMatch',              'debug',      'NONE',       'bold',            'ansi_magenta',    'NONE',  'NONE')
hi('LeapLabelPrimary',       'black',      'white',      'bold',            'ansi_magenta',    'NONE',  'NONE')
hi('LeapLabelSecondary',     'white',      'l1_blue',    'bold',            'ansi_brmagenta',  'NONE',  'bold')
hi('LeapLabelSelected',      'debug',      'NONE',       'bold',            'ansi_brmagenta',  'NONE',  'bold')
hi('MiniCursorword',         'NONE',       'NONE',       'bold,underline',  'NONE',            'NONE',  'bold,underline')
hi('MiniIndentscopeSymbol',  'ds_cyan_3',  'NONE',       'NONE',            'ansi_brblack',    'NONE',  'NONE')
hi('LualineDiffAdd',         'd1_green',   'ds_blue_4',  'bold',            'ansi_green',      'NONE',  'NONE')
hi('LualineDiffChange',      'yellow',     'ds_blue_4',  'bold',            'ansi_yellow',     'NONE',  'NONE')
hi('LualineDiffDelete',      'red',        'ds_blue_4',  'bold',            'ansi_red',        'NONE',  'NONE')
hi('LualineDiagError',       'red',        'ds_blue_4',  'bold',            'ansi_green',      'NONE',  'NONE')
hi('LualineDiagWarn',        'yellow',     'ds_blue_4',  'bold',            'ansi_yellow',     'NONE',  'NONE')
hi('LualineDiagInfo',        'white',      'ds_blue_4',  'bold',            'ansi_red',        'NONE',  'NONE')
hi('LualineDiagHint',        'l2_purple',  'ds_blue_4',  'bold',            'ansi_red',        'NONE',  'NONE')

-- group                      | target
ln('CmpMenuBackground',       'CMenuNormal')
ln('CmpMenuSelect',           'CMenuSelection')
ln('CmpItemAbbr',             'CMenuItem')
ln('CmpItemAbbrMatch',        'CMenuItemMatch')
ln('CmpItemKind',             'Type')
ln('TelescopeNormal',         'FloatMenuNormal')
ln('TelescopeBorder',         'WinSeparator')
ln('TelescopeTitle',          'Title')
ln('TelescopePromptCounter',  'TelescopeTitle')
ln('TelescopeMatching',       'FloatMenuItemMatch')
ln('TelescopeSelection',      'FloatMenuSelection')
ln('TelescopePreviewNormal',  'Normal')

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

-- Highlight notes everywhere, just like todos.
vim.api.nvim_create_augroup('HighlightNotes', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
    group = 'HighlightNotes',
    callback = function()
        vim.fn.matchadd('Todo', 'TODO:\\|NOTE:')
    end,
})

