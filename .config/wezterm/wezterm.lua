--------------------------------------------------------------------------------
-- Wezterm configuration file
--------------------------------------------------------------------------------

local wezterm = require('wezterm')

local theme = require('mercury')

return {
    -- Disable warnings
    warn_about_missing_glyphs = false,

    -- Font
    font = wezterm.font(theme.font),
    font_size = 11.0,

    -- Key bindings
    disable_default_key_bindings = true,

    keys = {
        { key = 'c', mods = 'CTRL', action = wezterm.action{ CopyTo = 'ClipboardAndPrimarySelection' } },
        { key = 'v', mods = 'CTRL', action = wezterm.action{ PasteFrom = 'Clipboard' } },
    },

    -- Mouse bindings
    bypass_mouse_reporting_modifiers = 'SHIFT',

    mouse_bindings = {
        -- Ctrl-click will open the link under the mouse cursor
        {
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'CTRL',
            action = wezterm.action.OpenLinkAtMouseCursor,
        },
    },

    -- Disable tab bar
    enable_tab_bar = false,
    use_fancy_tab_bar = false,

    -- Window
    adjust_window_size_when_changing_font_size = false,

    window_padding = {
        left   = 0,
        right  = 0,
        top    = 0,
        bottom = 0,
    },

    -- Terminal bell
    audible_bell = 'Disabled',

    visual_bell = {
        fade_in_function = 'Linear',
        fade_in_duration_ms = 0,
        fade_out_function = 'EaseOut',
        fade_out_duration_ms = 150,
    },

    -- Colors
    window_background_gradient = {
        colors = { theme.colors.extra_dark.blue, theme.colors.greyscale.g0 },
        orientation = { Linear = { angle = -60.0 } },
    },

    colors = {
        visual_bell = theme.colors.normal.blue,

        tab_bar = {
            background = theme.colors.greyscale.g0,

            active_tab = {
                bg_color = theme.colors.greyscale.g0,
                fg_color = theme.colors.greyscale.g6,

                intensity = 'Bold',
            },

            inactive_tab = {
                bg_color = theme.colors.greyscale.g0,
                fg_color = theme.colors.greyscale.g3,

                intensity = 'Normal',
            },

            inactive_tab_hover = {
                bg_color = theme.colors.greyscale.g1,
                fg_color = theme.colors.greyscale.g4,
            },

            new_tab = {
                bg_color = theme.colors.greyscale.g0,
                fg_color = theme.colors.greyscale.g3,
            },

            new_tab_hover = {
                bg_color = theme.colors.greyscale.g1,
                fg_color = theme.colors.greyscale.g4,
            },
        },

        background = theme.colors.extra_dark.blue,
        foreground = theme.colors.greyscale.g6,

        cursor_bg = theme.colors.greyscale.g7,
        cursor_fg = theme.colors.greyscale.g0,

        selection_bg = theme.colors.bright.magenta,
        selection_fg = theme.colors.greyscale.g0,

        ansi = {
            theme.colors.greyscale.g0,
            theme.colors.normal.red,
            theme.colors.normal.green,
            theme.colors.normal.yellow,
            theme.colors.normal.blue,
            theme.colors.normal.magenta,
            theme.colors.normal.cyan,
            theme.colors.greyscale.g6,
        },

        brights = {
            theme.colors.greyscale.g3,
            theme.colors.bright.red,
            theme.colors.bright.green,
            theme.colors.bright.yellow,
            theme.colors.bright.blue,
            theme.colors.bright.magenta,
            theme.colors.bright.cyan,
            theme.colors.greyscale.g7,
        },

        indexed = {
            [16] = theme.colors.greyscale.g2,
            [17] = theme.colors.dark.red,
            [18] = theme.colors.dark.green,
            [19] = theme.colors.dark.yellow,
            [20] = theme.colors.dark.blue,
            [21] = theme.colors.dark.magenta,
            [22] = theme.colors.dark.cyan,
            [23] = theme.colors.greyscale.g5,

            [24] = theme.colors.greyscale.g1,
            [25] = theme.colors.extra_dark.red,
            [26] = theme.colors.extra_dark.green,
            [27] = theme.colors.extra_dark.yellow,
            [28] = theme.colors.extra_dark.blue,
            [29] = theme.colors.extra_dark.magenta,
            [30] = theme.colors.extra_dark.cyan,
            [31] = theme.colors.greyscale.g4,
        },
    },
}
