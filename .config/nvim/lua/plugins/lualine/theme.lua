--------------------------------------------------------------------------------
-- Lualine theme
--------------------------------------------------------------------------------

-- Retrieve system colors
--------------------------------------------------------------------------------

local colors_path = os.getenv('XDG_CONFIG_HOME') .. [[/colors/?.lua;]]
local PathUtils = require('utils.path')

PathUtils.prepend_to_package_path(colors_path)

local Colors = require('lua-colors')

Colors.parse_colors()

-- Construct theme
--------------------------------------------------------------------------------

local colors = {
    theme_1_fg  = Colors.hash('l4_blue'),
    theme_2_fg  = Colors.hash('ds_blue_6'),
    theme_3_fg  = Colors.hash('ds_blue_6'),
    theme_1_bg  = Colors.hash('ds_blue_4'),
    theme_2_bg  = Colors.hash('ds_blue_2'),
    theme_3_bg  = Colors.hash('editor_bg'),
    normal_fg   = Colors.hash('l4_blue'),
    normal_bg   = Colors.hash('ds_blue_4'),
    insert_bg   = Colors.hash('d3_green'),
    insert_fg   = Colors.hash('green'),
    visual_bg   = Colors.hash('d1_magenta'),
    visual_fg   = Colors.hash('l4_magenta'),
    command_bg  = Colors.hash('d2_orange'),
    command_fg  = Colors.hash('l1_yellow'),
    replace_bg  = Colors.hash('d2_purple'),
    replace_fg  = Colors.hash('l3_purple'),
    inactive_fg = Colors.hash('ds_blue_5'),
    inactive_bg = Colors.hash('ds_blue_1'),
}

return {
    normal = {
        a = { bg = colors.normal_bg, fg = colors.normal_fg, gui = 'bold' },
        b = { bg = colors.theme_2_bg, fg = colors.theme_2_fg },
        c = { bg = colors.theme_3_bg, fg = colors.theme_3_fg },
        x = { bg = colors.theme_3_bg, fg = colors.theme_3_fg },
        y = { bg = colors.theme_2_bg, fg = colors.theme_2_fg },
        z = { bg = colors.theme_1_bg, fg = colors.theme_1_fg },
    },
    insert = {
        a = { bg = colors.insert_bg, fg = colors.insert_fg, gui = 'bold' },
        b = { bg = colors.theme_2_bg, fg = colors.theme_2_fg },
        c = { bg = colors.theme_3_bg, fg = colors.theme_3_fg },
        x = { bg = colors.theme_3_bg, fg = colors.theme_3_fg },
        y = { bg = colors.theme_2_bg, fg = colors.theme_2_fg },
        z = { bg = colors.theme_1_bg, fg = colors.theme_1_fg },
    },
    visual = {
        a = { bg = colors.visual_bg, fg = colors.visual_fg, gui = 'bold' },
        b = { bg = colors.theme_2_bg, fg = colors.theme_2_fg },
        c = { bg = colors.theme_3_bg, fg = colors.theme_3_fg },
        x = { bg = colors.theme_3_bg, fg = colors.theme_3_fg },
        y = { bg = colors.theme_2_bg, fg = colors.theme_2_fg },
        z = { bg = colors.theme_1_bg, fg = colors.theme_1_fg },
    },
    replace = {
        a = { bg = colors.replace_bg, fg = colors.replace_fg, gui = 'bold' },
        b = { bg = colors.theme_2_bg, fg = colors.theme_2_fg },
        c = { bg = colors.theme_3_bg, fg = colors.theme_3_fg },
        x = { bg = colors.theme_3_bg, fg = colors.theme_3_fg },
        y = { bg = colors.theme_2_bg, fg = colors.theme_2_fg },
        z = { bg = colors.theme_1_bg, fg = colors.theme_1_fg },
    },
    command = {
        a = { bg = colors.command_bg, fg = colors.command_fg, gui = 'bold' },
        b = { bg = colors.theme_2_bg, fg = colors.theme_2_fg },
        c = { bg = colors.theme_3_bg, fg = colors.theme_3_fg },
        x = { bg = colors.theme_3_bg, fg = colors.theme_3_fg },
        y = { bg = colors.theme_2_bg, fg = colors.theme_2_fg },
        z = { bg = colors.theme_1_bg, fg = colors.theme_1_fg },
    },
    inactive = {
        a = { bg = colors.inactive_bg, fg = colors.inactive_fg, gui = 'bold' },
        b = { bg = colors.inactive_bg, fg = colors.inactive_fg },
        c = { bg = colors.inactive_bg, fg = colors.inactive_fg },
        x = { bg = colors.theme_3_bg, fg = colors.theme_3_fg },
        y = { bg = colors.theme_2_bg, fg = colors.theme_2_fg },
        z = { bg = colors.inactive_bg, fg = colors.inactive_fg },
    }
}

