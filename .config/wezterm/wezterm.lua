--------------------------------------------------------------------------------
-- Wezterm configuration file
--------------------------------------------------------------------------------

local wezterm = require('wezterm')

-- Import system colors
package.path = os.getenv('XDG_CONFIG_HOME') .. '/colors' .. [[/?.lua]]

local colors = require('lua-colors')
colors.parse_colors()

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

--------------------------------------------------------------------------------
-- Keyboard input
--------------------------------------------------------------------------------

    -- NOTE: We don't need any of the defaults.
    -- see: https://wezfurlong.org/wezterm/config/default-keys.html
    disable_default_key_bindings = true,

    keys = {
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
        {
            key = 'd',
            mods = 'CTRL',
            action = wezterm.action_callback(function(window, pane)
                if pane:is_alt_screen_active() then
                    window:perform_action(wezterm.action.SendKey { key = 'd', mods = 'CTRL' }, pane)
                else
                    window:perform_action(wezterm.action.ScrollByPage(0.5), pane)
                end
            end),
        },
        {
            key = 'u',
            mods = 'CTRL',
            action = wezterm.action_callback(function(window, pane)
                if pane:is_alt_screen_active() then
                    window:perform_action(wezterm.action.SendKey { key = 'u', mods = 'CTRL' }, pane)
                else
                    window:perform_action(wezterm.action.ScrollByPage(-0.5), pane)
                end
            end),
        },
    },

--------------------------------------------------------------------------------
-- Mouse input
--------------------------------------------------------------------------------

    -- Mouse bindings
    bypass_mouse_reporting_modifiers = 'SHIFT',

--------------------------------------------------------------------------------
-- Appearance
--------------------------------------------------------------------------------

    -- Don't render bold as bright.
    bold_brightens_ansi_colors = false,

    -- Font
    font = wezterm.font({
        family = 'Fira Code',
        weight = 'Regular',
    }),
    font_size = 11.0,

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
        fade_out_duration_ms = 400,
    },

--------------------------------------------------------------------------------
-- Colors
--------------------------------------------------------------------------------

    -- Window gradient
    window_background_gradient = {
        colors = { colors.named('d2_blue'), colors.named('black') },
        orientation = { Linear = { angle = -60.0 } },
    },

    -- TODO: Use system colors from lua_colors.lua
    -- Color scheme mapping
    colors = {
        visual_bell = colors.named('blue'),

        tab_bar = {
            background = colors.named('black'),

            active_tab = {
                bg_color = colors.named('black'),
                fg_color = colors.named('white'),

                intensity = 'Bold',
            },

            inactive_tab = {
                bg_color = colors.named('black'),
                fg_color = colors.named('gray'),

                intensity = 'Normal',
            },

            inactive_tab_hover = {
                bg_color = colors.named('d3_gray'),
                fg_color = colors.named('l1_gray'),
            },

            new_tab = {
                bg_color = colors.named('black'),
                fg_color = colors.named('gray'),
            },

            new_tab_hover = {
                bg_color = colors.named('d3_gray'),
                fg_color = colors.named('l1_gray'),
            },
        },

        background = colors.named('d2_blue'),
        foreground = colors.named('white'),

        cursor_bg = colors.named('l1_white'),
        cursor_fg = colors.named('black'),

        selection_bg = colors.named('l1_magenta'),
        selection_fg = colors.named('black'),

        ansi = {
            colors.named('black'),
            colors.named('red'),
            colors.named('green'),
            colors.named('yellow'),
            colors.named('blue'),
            colors.named('magenta'),
            colors.named('cyan'),
            colors.named('white'),
        },

        brights = {
            colors.named('gray'),
            colors.named('l1_red'),
            colors.named('l1_green'),
            colors.named('l1_yellow'),
            colors.named('l1_blue'),
            colors.named('l1_magenta'),
            colors.named('l1_cyan'),
            colors.named('l1_white'),
        },

        indexed = {
            [16] = colors.named('d2_gray'),
            [17] = colors.named('d1_red'),
            [18] = colors.named('d1_green'),
            [19] = colors.named('d1_yellow'),
            [20] = colors.named('d1_blue'),
            [21] = colors.named('d1_magenta'),
            [22] = colors.named('d1_cyan'),
            [23] = colors.named('l2_gray'),

            [24] = colors.named('d3_gray'),
            [25] = colors.named('d2_red'),
            [26] = colors.named('d2_green'),
            [27] = colors.named('d2_yellow'),
            [28] = colors.named('d2_blue'),
            [29] = colors.named('d2_magenta'),
            [30] = colors.named('d2_cyan'),
            [31] = colors.named('l1_gray'),
        },
    },
}
