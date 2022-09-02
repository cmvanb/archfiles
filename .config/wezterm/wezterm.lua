--------------------------------------------------------------------------------
-- Wezterm configuration file
--------------------------------------------------------------------------------

local wezterm = require('wezterm')

local theme = require('mercury')

return {
--------------------------------------------------------------------------------
-- General settings
--------------------------------------------------------------------------------

    -- Disable warnings
    warn_about_missing_glyphs = false,

    -- NOTE: Enabling this causes issues with vim-sandwich in NVIM.
    -- Keyboard input settings
    enable_kitty_keyboard = false,

    -- Disable tab bar
    enable_tab_bar = false,
    use_fancy_tab_bar = false,

    -- Window
    adjust_window_size_when_changing_font_size = false,

    -- Terminal bell
    audible_bell = 'Disabled',
    visual_bell = {
        fade_in_function = 'Linear',
        fade_in_duration_ms = 0,
        fade_out_function = 'EaseOut',
        fade_out_duration_ms = 400,
    },

--------------------------------------------------------------------------------
-- Keyboard input
--------------------------------------------------------------------------------

    -- NOTE: We don't need any of the defaults.
    -- see: https://wezfurlong.org/wezterm/config/default-keys.html
    disable_default_key_bindings = true,

    -- TODO: Add page scroll binds (CTRL+D/CTRL+U). Depends on stty interrupt rebindings.

    keys = {
        -- TODO: Decide on interrupt bindings. Attempt with stty first?
        -- { key = 'q', mods = 'CTRL', action = wezterm.action.SendKey { key = 'c', mods = 'CTRL' } },
        {
            key = 'c',
            mods = 'CTRL',
            action = wezterm.action_callback(function(window, pane)
                if pane:is_alt_screen_active() then
                    window:perform_action(wezterm.action.SendKey { key = 'c', mods = 'CTRL' }, pane)
                else
                    window:perform_action(wezterm.action { CopyTo = 'ClipboardAndPrimarySelection' }, pane)
                end
            end),
        },
        { key = 'v', mods = 'CTRL', action = wezterm.action { PasteFrom = 'Clipboard' } },
    },

--------------------------------------------------------------------------------
-- Mouse input
--------------------------------------------------------------------------------

    -- Mouse bindings
    bypass_mouse_reporting_modifiers = 'SHIFT',

--------------------------------------------------------------------------------
-- Rendering
--------------------------------------------------------------------------------

    -- Font
    font = wezterm.font({
        family = 'Fira Code',
        weight = 'Regular',
    }),
    font_size = 11.0,

    -- Window padding
    window_padding = {
        left   = 0,
        right  = 0,
        top    = 0,
        bottom = 0,
    },

--------------------------------------------------------------------------------
-- Colors
--------------------------------------------------------------------------------

    -- Window gradient
    window_background_gradient = {
        colors = { theme.colors.extra_dark.blue, theme.colors.greyscale.g0 },
        orientation = { Linear = { angle = -60.0 } },
    },

    -- TODO: Use system colors from lua_colors.lua
    -- Color scheme mapping
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
