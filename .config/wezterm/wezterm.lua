--------------------------------------------------------------------------------
-- Wezterm configuration file
--------------------------------------------------------------------------------

local wezterm = require('wezterm')

-- Import system colors
package.path = os.getenv('XDG_CONFIG_HOME') .. '/colors' .. [[/?.lua]]

local colors = require('lua-colors')
colors.parse_colors()

-- Introduce some alternate mappings to `alt-screen` applications such as 
-- terminal NVIM.
function alt_action(window, pane, alt_screen_action, terminal_action)
    return wezterm.action_callback(function(window, pane)
        if pane:is_alt_screen_active() then
            window:perform_action(alt_screen_action, pane)
        else
            window:perform_action(terminal_action, pane)
        end
    end)
end

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
        -- Spawn new terminal in current directory
        {
            key = 'n',
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
        family = 'Iosevka Nerd Font Mono',
        -- family = 'Hack NF JBM Ligatured',
        -- family = 'MesloLGS NF',
        -- family = 'Fira Code',
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
        visual_bell = colors.hash('l1_blue'),

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

        background = colors.hash('terminal_bg'),
        foreground = colors.hash('white'),

        cursor_bg = colors.hash('l1_white'),
        cursor_fg = colors.hash('black'),

        selection_bg = colors.hash('magenta'),
        selection_fg = colors.hash('black'),

        ansi = {
            colors.hash('ansi_black'),
            colors.hash('ansi_red'),
            colors.hash('ansi_green'),
            colors.hash('ansi_yellow'),
            colors.hash('ansi_blue'),
            colors.hash('ansi_magenta'),
            colors.hash('ansi_cyan'),
            colors.hash('ansi_white'),
        },

        brights = {
            colors.hash('ansi_brblack'),
            colors.hash('ansi_brred'),
            colors.hash('ansi_brgreen'),
            colors.hash('ansi_bryellow'),
            colors.hash('ansi_brblue'),
            colors.hash('ansi_brmagenta'),
            colors.hash('ansi_brcyan'),
            colors.hash('ansi_brwhite'),
        },

        -- TODO: Update indexed colors.
        indexed = {
            [16] = colors.hash('d5_gray'),
            [17] = colors.hash('d4_gray'),
            [18] = colors.hash('d3_gray'),
            [19] = colors.hash('d2_gray'),
            [20] = colors.hash('d1_gray'),
            [21] = colors.hash('gray'),
            [22] = colors.hash('l1_gray'),
            [23] = colors.hash('l2_gray'),
            [24] = colors.hash('l3_gray'),
            [25] = colors.hash('l4_gray'),

            [26] = colors.hash('d5_red'),
            [27] = colors.hash('d4_red'),
            [28] = colors.hash('d3_red'),
            [29] = colors.hash('d2_red'),
            [30] = colors.hash('d1_red'),
            [31] = colors.hash('red'),
            [32] = colors.hash('l1_red'),
            [33] = colors.hash('l2_red'),
            [34] = colors.hash('l3_red'),
            [35] = colors.hash('l4_red'),

            [36] = colors.hash('d5_orange'),
            [37] = colors.hash('d4_orange'),
            [38] = colors.hash('d3_orange'),
            [39] = colors.hash('d2_orange'),
            [40] = colors.hash('d1_orange'),
            [41] = colors.hash('orange'),
            [42] = colors.hash('l1_orange'),
            [43] = colors.hash('l2_orange'),
            [44] = colors.hash('l3_orange'),
            [45] = colors.hash('l4_orange'),

            [46] = colors.hash('d5_yellow'),
            [47] = colors.hash('d4_yellow'),
            [48] = colors.hash('d3_yellow'),
            [49] = colors.hash('d2_yellow'),
            [50] = colors.hash('d1_yellow'),
            [51] = colors.hash('yellow'),
            [52] = colors.hash('l1_yellow'),
            [53] = colors.hash('l2_yellow'),
            [54] = colors.hash('l3_yellow'),
            [55] = colors.hash('l4_yellow'),

            [56] = colors.hash('d5_green'),
            [57] = colors.hash('d4_green'),
            [58] = colors.hash('d3_green'),
            [59] = colors.hash('d2_green'),
            [60] = colors.hash('d1_green'),
            [61] = colors.hash('green'),
            [62] = colors.hash('l1_green'),
            [63] = colors.hash('l2_green'),
            [64] = colors.hash('l3_green'),
            [65] = colors.hash('l4_green'),

            [66] = colors.hash('d5_cyan'),
            [67] = colors.hash('d4_cyan'),
            [68] = colors.hash('d3_cyan'),
            [69] = colors.hash('d2_cyan'),
            [70] = colors.hash('d1_cyan'),
            [71] = colors.hash('cyan'),
            [72] = colors.hash('l1_cyan'),
            [73] = colors.hash('l2_cyan'),
            [74] = colors.hash('l3_cyan'),
            [75] = colors.hash('l4_cyan'),

            [76] = colors.hash('d5_blue'),
            [77] = colors.hash('d4_blue'),
            [78] = colors.hash('d3_blue'),
            [79] = colors.hash('d2_blue'),
            [80] = colors.hash('d1_blue'),
            [81] = colors.hash('blue'),
            [82] = colors.hash('l1_blue'),
            [83] = colors.hash('l2_blue'),
            [84] = colors.hash('l3_blue'),
            [85] = colors.hash('l4_blue'),

            [86] = colors.hash('d5_purple'),
            [87] = colors.hash('d4_purple'),
            [88] = colors.hash('d3_purple'),
            [89] = colors.hash('d2_purple'),
            [90] = colors.hash('d1_purple'),
            [91] = colors.hash('purple'),
            [92] = colors.hash('l1_purple'),
            [93] = colors.hash('l2_purple'),
            [94] = colors.hash('l3_purple'),
            [95] = colors.hash('l4_purple'),

            [96] = colors.hash('d5_magenta'),
            [97] = colors.hash('d4_magenta'),
            [98] = colors.hash('d3_magenta'),
            [99] = colors.hash('d2_magenta'),
            [100] = colors.hash('d1_magenta'),
            [101] = colors.hash('magenta'),
            [102] = colors.hash('l1_magenta'),
            [103] = colors.hash('l2_magenta'),
            [104] = colors.hash('l3_magenta'),
            [105] = colors.hash('l4_magenta'),
        },
    },
}
