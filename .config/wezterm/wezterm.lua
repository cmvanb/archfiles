--------------------------------------------------------------------------------
-- Wezterm configuration file
--------------------------------------------------------------------------------

local wezterm = require('wezterm')

-- Retrieve system theme
--------------------------------------------------------------------------------

package.path = os.getenv('XDG_CONFIG_HOME') .. '/theme' .. [[/?.lua]]
local theme = require('theme')

-- Helpers
--------------------------------------------------------------------------------

-- Create alternate mappings to `alt-screen` applications such as terminal NVIM.
local function alt_action(window, pane, alt_screen_action, terminal_action)
    return wezterm.action_callback(function(window, pane)
        if pane:is_alt_screen_active() then
            window:perform_action(alt_screen_action, pane)
        else
            window:perform_action(terminal_action, pane)
        end
    end)
end

return {

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
        -- Spawn new terminal in current directory
        {
            key = 't',
            mods = 'CTRL',
            action = wezterm.action.SpawnWindow,
        },
        -- Copy
        {
            key = 'c',
            mods = 'CTRL',
            action = alt_action(
                window, pane,
                wezterm.action.SendKey { key = 'c', mods = 'CTRL' },
                wezterm.action { CopyTo = 'ClipboardAndPrimarySelection' }
            ),
        },
        -- Paste
        {
            key = 'v',
            mods = 'CTRL',
            action = wezterm.action { PasteFrom = 'Clipboard' },
        },
        -- STTY interrupt passthrough
        {
            key = 'x',
            mods = 'CTRL',
            action = wezterm.action.SendKey { key = 'c', mods = 'CTRL' },
        },
        -- STTY interrupt passthrough
        {
            key = 'e',
            mods = 'CTRL',
            action = wezterm.action.SendKey { key = 'd', mods = 'CTRL' },
        },
        -- Scroll down half-page
        {
            key = 'd',
            mods = 'CTRL',
            action = alt_action(
                window, pane,
                wezterm.action.SendKey { key = 'd', mods = 'CTRL' },
                wezterm.action.ScrollByPage(0.5)
            ),
        },
        -- Scroll up half-page
        {
            key = 'u',
            mods = 'CTRL',
            action = alt_action(
                window, pane,
                wezterm.action.SendKey { key = 'u', mods = 'CTRL' },
                wezterm.action.ScrollByPage(-0.5)
            ),
        },
        -- Scroll down one line
        {
            key = 'j',
            mods = 'CTRL',
            action = alt_action(
                window, pane,
                wezterm.action.SendKey { key = 'j', mods = 'CTRL' },
                wezterm.action.ScrollByLine(1)
            ),
        },
        -- Scroll up one line
        {
            key = 'k',
            mods = 'CTRL',
            action = alt_action(
                window, pane,
                wezterm.action.SendKey { key = 'k', mods = 'CTRL' },
                wezterm.action.ScrollByLine(-1)
            ),
        },
        -- Key passthrough
        -- It's not possible for NVIM to distinguish <C-i> from <Tab>, or
        -- <C-m> from <CR>, or <C-BS> from <C-H>. Best we can do is pass escape  
        -- codes for unused function keys. Use `showkeys -a` to find codes for 
        -- specific keys.
        --  see: https://www.reddit.com/r/neovim/comments/mbj8m5/how_to_setup_ctrlshiftkey_mappings_in_neovim_and/
        --  see: https://en.wikipedia.org/wiki/List_of_Unicode_characters#Basic_Latin
        {
            key = 'i',
            mods = 'CTRL',
            action = alt_action(
                window, pane,
                wezterm.action { SendString = '\x1b[1;2P' },
                wezterm.action.Nop
            ),
        },
        {
            key = 'm',
            mods = 'CTRL',
            action = alt_action(
                window, pane,
                wezterm.action { SendString = '\x1b[1;2Q' },
                wezterm.action.Nop
            ),
        },
        {
            key = 'Backspace',
            mods = 'CTRL',
            action = alt_action(
                window, pane,
                wezterm.action { SendString = '\x1b[1;2R' },
                wezterm.action.Nop
            ),
        },
        {
            key = 'Tab',
            mods = 'CTRL',
            action = alt_action(
                window, pane,
                wezterm.action { SendString = '\x1b[9;5u' },
                wezterm.action.Nop
            ),
        },
        {
            key = 'q',
            mods = 'CTRL|SHIFT',
            action = alt_action(
                window, pane,
                wezterm.action { SendString = '\x1b[81;5u' },
                wezterm.action.Nop
            ),
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
        family = theme.font('font_mono'),
        weight = 'Regular',
    }),
    font_size = 12.0,

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
        fade_out_duration_ms = 200,
    },

--------------------------------------------------------------------------------
-- Colors
--------------------------------------------------------------------------------

    -- Color scheme mapping
    colors = {
        visual_bell = theme.color_hash('l1_blue'),

        tab_bar = {
            background = theme.color_hash('black'),

            active_tab = {
                bg_color = theme.color_hash('black'),
                fg_color = theme.color_hash('white'),

                intensity = 'Bold',
            },

            inactive_tab = {
                bg_color = theme.color_hash('black'),
                fg_color = theme.color_hash('gray'),

                intensity = 'Normal',
            },

            inactive_tab_hover = {
                bg_color = theme.color_hash('d3_gray'),
                fg_color = theme.color_hash('l1_gray'),
            },

            new_tab = {
                bg_color = theme.color_hash('black'),
                fg_color = theme.color_hash('gray'),
            },

            new_tab_hover = {
                bg_color = theme.color_hash('d3_gray'),
                fg_color = theme.color_hash('l1_gray'),
            },
        },

        background = theme.color_hash('terminal_bg'),
        foreground = theme.color_hash('white'),

        cursor_bg = theme.color_hash('text_7'),
        cursor_fg = theme.color_hash('text_0'),

        selection_bg = theme.color_hash('magenta'),
        selection_fg = theme.color_hash('black'),

        ansi = {
            theme.color_hash('ansi_black'),
            theme.color_hash('ansi_red'),
            theme.color_hash('ansi_green'),
            theme.color_hash('ansi_yellow'),
            theme.color_hash('ansi_blue'),
            theme.color_hash('ansi_magenta'),
            theme.color_hash('ansi_cyan'),
            theme.color_hash('ansi_white'),
        },

        brights = {
            theme.color_hash('ansi_brblack'),
            theme.color_hash('ansi_brred'),
            theme.color_hash('ansi_brgreen'),
            theme.color_hash('ansi_bryellow'),
            theme.color_hash('ansi_brblue'),
            theme.color_hash('ansi_brmagenta'),
            theme.color_hash('ansi_brcyan'),
            theme.color_hash('ansi_brwhite'),
        },

        -- TODO: Update indexed colors.
        indexed = {
            [16] = theme.color_hash('d5_gray'),
            [17] = theme.color_hash('d4_gray'),
            [18] = theme.color_hash('d3_gray'),
            [19] = theme.color_hash('d2_gray'),
            [20] = theme.color_hash('d1_gray'),
            [21] = theme.color_hash('gray'),
            [22] = theme.color_hash('l1_gray'),
            [23] = theme.color_hash('l2_gray'),
            [24] = theme.color_hash('l3_gray'),
            [25] = theme.color_hash('l4_gray'),

            [26] = theme.color_hash('d5_red'),
            [27] = theme.color_hash('d4_red'),
            [28] = theme.color_hash('d3_red'),
            [29] = theme.color_hash('d2_red'),
            [30] = theme.color_hash('d1_red'),
            [31] = theme.color_hash('red'),
            [32] = theme.color_hash('l1_red'),
            [33] = theme.color_hash('l2_red'),
            [34] = theme.color_hash('l3_red'),
            [35] = theme.color_hash('l4_red'),

            [36] = theme.color_hash('d5_orange'),
            [37] = theme.color_hash('d4_orange'),
            [38] = theme.color_hash('d3_orange'),
            [39] = theme.color_hash('d2_orange'),
            [40] = theme.color_hash('d1_orange'),
            [41] = theme.color_hash('orange'),
            [42] = theme.color_hash('l1_orange'),
            [43] = theme.color_hash('l2_orange'),
            [44] = theme.color_hash('l3_orange'),
            [45] = theme.color_hash('l4_orange'),

            [46] = theme.color_hash('d5_yellow'),
            [47] = theme.color_hash('d4_yellow'),
            [48] = theme.color_hash('d3_yellow'),
            [49] = theme.color_hash('d2_yellow'),
            [50] = theme.color_hash('d1_yellow'),
            [51] = theme.color_hash('yellow'),
            [52] = theme.color_hash('l1_yellow'),
            [53] = theme.color_hash('l2_yellow'),
            [54] = theme.color_hash('l3_yellow'),
            [55] = theme.color_hash('l4_yellow'),

            [56] = theme.color_hash('d5_green'),
            [57] = theme.color_hash('d4_green'),
            [58] = theme.color_hash('d3_green'),
            [59] = theme.color_hash('d2_green'),
            [60] = theme.color_hash('d1_green'),
            [61] = theme.color_hash('green'),
            [62] = theme.color_hash('l1_green'),
            [63] = theme.color_hash('l2_green'),
            [64] = theme.color_hash('l3_green'),
            [65] = theme.color_hash('l4_green'),

            [66] = theme.color_hash('d5_cyan'),
            [67] = theme.color_hash('d4_cyan'),
            [68] = theme.color_hash('d3_cyan'),
            [69] = theme.color_hash('d2_cyan'),
            [70] = theme.color_hash('d1_cyan'),
            [71] = theme.color_hash('cyan'),
            [72] = theme.color_hash('l1_cyan'),
            [73] = theme.color_hash('l2_cyan'),
            [74] = theme.color_hash('l3_cyan'),
            [75] = theme.color_hash('l4_cyan'),

            [76] = theme.color_hash('d5_blue'),
            [77] = theme.color_hash('d4_blue'),
            [78] = theme.color_hash('d3_blue'),
            [79] = theme.color_hash('d2_blue'),
            [80] = theme.color_hash('d1_blue'),
            [81] = theme.color_hash('blue'),
            [82] = theme.color_hash('l1_blue'),
            [83] = theme.color_hash('l2_blue'),
            [84] = theme.color_hash('l3_blue'),
            [85] = theme.color_hash('l4_blue'),

            [86] = theme.color_hash('d5_purple'),
            [87] = theme.color_hash('d4_purple'),
            [88] = theme.color_hash('d3_purple'),
            [89] = theme.color_hash('d2_purple'),
            [90] = theme.color_hash('d1_purple'),
            [91] = theme.color_hash('purple'),
            [92] = theme.color_hash('l1_purple'),
            [93] = theme.color_hash('l2_purple'),
            [94] = theme.color_hash('l3_purple'),
            [95] = theme.color_hash('l4_purple'),

            [96] = theme.color_hash('d5_magenta'),
            [97] = theme.color_hash('d4_magenta'),
            [98] = theme.color_hash('d3_magenta'),
            [99] = theme.color_hash('d2_magenta'),
            [100] = theme.color_hash('d1_magenta'),
            [101] = theme.color_hash('magenta'),
            [102] = theme.color_hash('l1_magenta'),
            [103] = theme.color_hash('l2_magenta'),
            [104] = theme.color_hash('l3_magenta'),
            [105] = theme.color_hash('l4_magenta'),
        },
    },
}
