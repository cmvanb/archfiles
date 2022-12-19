--------------------------------------------------------------------------------
-- Lualine theme
--------------------------------------------------------------------------------

local theme = require('system.theme')

local colors = {
    theme_1_bg  = theme.color_hash('primary_6'),
    theme_1_fg  = theme.color_hash('text_7'),
    theme_2_bg  = theme.color_hash('primary_4'),
    theme_2_fg  = theme.color_hash('text_2'),
    theme_3_bg  = theme.color_hash('primary_2'),
    theme_3_fg  = theme.color_hash('text_1'),
    inactive_bg = theme.color_hash('primary_1'),
    inactive_fg = theme.color_hash('text_1'),

    normal_bg   = theme.color_hash('primary_6'),
    normal_fg   = theme.color_hash('text_7'),
    insert_bg   = theme.color_hash('d3_green'),
    insert_fg   = theme.color_hash('green'),
    visual_bg   = theme.color_hash('d1_magenta'),
    visual_fg   = theme.color_hash('l4_magenta'),
    command_bg  = theme.color_hash('d2_orange'),
    command_fg  = theme.color_hash('l1_yellow'),
    replace_bg  = theme.color_hash('d2_purple'),
    replace_fg  = theme.color_hash('l3_purple'),
}

-- Construct theme
--------------------------------------------------------------------------------

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
        x = { bg = colors.inactive_bg, fg = colors.inactive_fg },
        y = { bg = colors.inactive_bg, fg = colors.inactive_fg },
        z = { bg = colors.inactive_bg, fg = colors.inactive_fg },
    }
}

