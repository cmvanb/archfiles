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

    -- NOTE: Enabling this causes problems with vim-sandwich in NVIM.
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
        -- Copy
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
        -- Paste
        {
            key = 'v',
            mods = 'CTRL',
            action = wezterm.action { PasteFrom = 'Clipboard' },
        },
        -- Scroll down
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
        -- Scroll up
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
        -- TODO: Improve this key bind.
        -- Close pane
        {
            key = 'q',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.CloseCurrentPane { confirm = true },
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
        colors = { colors.hash('d2_blue'), colors.hash('black') },
        orientation = { Linear = { angle = -60.0 } },
    },

    -- Color scheme mapping
    colors = {
        visual_bell = colors.hash('blue'),

        tab_bar = {
            background = colors.hash('black'),

            active_tab = {
                bg_color = colors.hash('black'),
                fg_color = colors.hash('white'),

                intensity = 'Bold',
            },

            inactive_tab = {
                bg_color = colors.hash('black'),
                fg_color = colors.hash('gray'),

                intensity = 'Normal',
            },

            inactive_tab_hover = {
                bg_color = colors.hash('d3_gray'),
                fg_color = colors.hash('l1_gray'),
            },

            new_tab = {
                bg_color = colors.hash('black'),
                fg_color = colors.hash('gray'),
            },

            new_tab_hover = {
                bg_color = colors.hash('d3_gray'),
                fg_color = colors.hash('l1_gray'),
            },
        },

        background = colors.hash('d2_blue'),
        foreground = colors.hash('white'),

        cursor_bg = colors.hash('l1_white'),
        cursor_fg = colors.hash('black'),

        selection_bg = colors.hash('l1_magenta'),
        selection_fg = colors.hash('black'),

        ansi = {
            colors.hash('black'),
            colors.hash('red'),
            colors.hash('green'),
            colors.hash('yellow'),
            colors.hash('blue'),
            colors.hash('magenta'),
            colors.hash('cyan'),
            colors.hash('white'),
        },

        brights = {
            colors.hash('gray'),
            colors.hash('l1_red'),
            colors.hash('l1_green'),
            colors.hash('l1_yellow'),
            colors.hash('l1_blue'),
            colors.hash('l1_magenta'),
            colors.hash('l1_cyan'),
            colors.hash('l1_white'),
        },

        indexed = {
            [16] = colors.hash('d2_gray'),
            [17] = colors.hash('d1_red'),
            [18] = colors.hash('d1_green'),
            [19] = colors.hash('d1_yellow'),
            [20] = colors.hash('d1_blue'),
            [21] = colors.hash('d1_magenta'),
            [22] = colors.hash('d1_cyan'),
            [23] = colors.hash('l2_gray'),

            [24] = colors.hash('d3_gray'),
            [25] = colors.hash('d2_red'),
            [26] = colors.hash('d2_green'),
            [27] = colors.hash('d2_yellow'),
            [28] = colors.hash('d2_blue'),
            [29] = colors.hash('d2_magenta'),
            [30] = colors.hash('d2_cyan'),
            [31] = colors.hash('l1_gray'),
        },
    },
}
