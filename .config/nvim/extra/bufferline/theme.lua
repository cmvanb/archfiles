--------------------------------------------------------------------------------
-- Bufferline theme
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
    debug           =  Colors.hash('debug'),
    background      =  Colors.hash('ds_blue_1'),
    hidden_bg       =  Colors.hash('ds_blue_0'),
    hidden_fg       =  Colors.hash('ds_blue_5'),
    visible_bg      =  Colors.hash('ds_blue_2'),
    visible_fg      =  Colors.hash('ds_blue_8'),
    selected_bg     =  Colors.hash('ds_blue_5'),
    selected_fg     =  Colors.hash('l4_blue'),
    selected_d1_fg  =  Colors.hash('ds_blue_9'),
    modified        =  Colors.hash('l1_orange'),
    pick_bg         =  Colors.hash('white'),
    pick_fg         =  Colors.hash('black'),
}

return {
    fill = {
        bg = colors.background,
    },

    tab = {
    },
    tab_selected = {
    },
    tab_close = {
    },

    -- Highlights the hidden buffers.
    background = {
        bg = colors.hidden_bg,
        fg = colors.hidden_fg,
    },

    close_button = {
        bg = colors.hidden_bg,
        fg = colors.hidden_fg,
    },
    close_button_visible = {
        bg = colors.visible_bg,
        fg = colors.visible_fg,
    },
    close_button_selected = {
        bg = colors.selected_bg,
        fg = colors.selected_fg,
    },

    buffer_visible = {
        bg = colors.visible_bg,
        fg = colors.visible_fg,
    },
    buffer_selected = {
        bg = colors.selected_bg,
        fg = colors.selected_fg,
        bold = true,
        italic = false,
    },

    numbers = {
        bg = colors.hidden_bg,
        fg = colors.hidden_fg,
    },
    numbers_visible = {
        bg = colors.visible_bg,
        fg = colors.visible_fg,
    },
    numbers_selected = {
        bg = colors.selected_bg,
        fg = colors.selected_fg,
        bold = true,
        italic = false,
    },

    diagnostic = {
    },
    diagnostic_visible = {
    },
    diagnostic_selected = {
        bold = true,
        italic = true,
    },

    hint = {
    },
    hint_visible = {
    },
    hint_selected = {
        bold = true,
        italic = false,
    },

    hint_diagnostic = {
    },
    hint_diagnostic_visible = {
    },
    hint_diagnostic_selected = {
        bold = true,
        italic = false,
    },

    info = {
    },
    info_visible = {
    },
    info_selected = {
        bold = true,
        italic = false,
    },

    info_diagnostic = {
    },
    info_diagnostic_visible = {
    },
    info_diagnostic_selected = {
        bold = true,
        italic = true,
    },

    warning = {
    },
    warning_visible = {
    },
    warning_selected = {
        bold = true,
        italic = false,
    },

    warning_diagnostic = {
    },
    warning_diagnostic_visible = {
    },
    warning_diagnostic_selected = {
        bold = true,
        italic = false,
    },

    error = {
    },
    error_visible = {
    },
    error_selected = {
        bold = true,
        italic = false,
    },

    error_diagnostic = {
    },
    error_diagnostic_visible = {
    },
    error_diagnostic_selected = {
        bold = true,
        italic = false,
    },

    modified = {
        bg = colors.hidden_bg,
        fg = colors.modified,
    },
    modified_visible = {
        bg = colors.visible_bg,
        fg = colors.modified,
    },
    modified_selected = {
        bg = colors.selected_bg,
        fg = colors.modified,
    },

    duplicate = {
        bg = colors.hidden_bg,
        fg = colors.hidden_fg,
        italic = false
    },
    duplicate_visible = {
        bg = colors.visible_bg,
        fg = colors.visible_fg,
        italic = false
    },
    duplicate_selected = {
        bg = colors.selected_bg,
        fg = colors.selected_d1_fg,
        italic = false,
    },

    separator = {
        bg = colors.hidden_bg,
        fg = colors.background,
    },
    separator_visible = {
        bg = colors.visible_bg,
        fg = colors.background,
    },
    separator_selected = {
        bg = colors.selected_bg,
        fg = colors.background,
    },

    indicator_visible = {
    },
    indicator_selected = {
    },

    pick = {
        bg = colors.pick_bg,
        fg = colors.pick_fg,
        bold = true,
        italic = false,
    },
    pick_visible = {
        bg = colors.pick_bg,
        fg = colors.pick_fg,
        bold = true,
        italic = false,
    },
    pick_selected = {
        bg = colors.pick_bg,
        fg = colors.pick_fg,
        bold = true,
        italic = false,
    },

    offset_separator = {
        -- bg = Colors.hash('debug'),
        -- fg = Colors.hash('white'),
    },
}

