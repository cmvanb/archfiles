--------------------------------------------------------------------------------
-- Lualine configuration
--------------------------------------------------------------------------------

local theme = reload('plugins.lualine.theme')

require('lualine').setup({
    options = {
        theme = theme,
        component_separators = ' ',
        section_separators = {
            left = '',
            right = '',
        },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {
            'branch',
            {
                'diff',
                colored = true,
                diff_color = {
                    added    = 'LualineDiffAdd',
                    modified = 'LualineDiffChange',
                    removed  = 'LualineDiffDelete',
                },
                symbols = {
                    added = '+',
                    modified = '~',
                    removed = '-',
                },
            },
        },
        lualine_c =
        {
            {
                'filename',
                path = 1,
            },
        },
        lualine_x = {},
        lualine_y = {
            {
                'diagnostics',
                 colored = true,
                 diagnostics_color = {
                    error = 'LualineDiagError',
                    warn  = 'LualineDiagWarn',
                    info  = 'LualineDiagInfo',
                    hint  = 'LualineDiagHint',
                },
                symbols = {
                    error = '✘ ',
                    warn = '⚠ ',
                    hint = ' ',
                    info = 'ℹ ',
                },
            },
            'filetype',
        },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            {
                'filename',
                path = 1,
            },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        lualine_a = {
            {
                'buffers',

                icons_enabled = false,
                padding = { left = 2, right = 2 },
                separator = nil,

                show_filename_only = true,   -- Shows shortened relative path when set to false.
                hide_filename_extension = false,   -- Hide filename extension when set to true.
                show_modified_status = true, -- Shows indicator when the buffer is modified.

                mode = 4, -- 0: Shows buffer name
                -- 1: Shows buffer index
                -- 2: Shows buffer name + buffer index
                -- 3: Shows buffer number
                -- 4: Shows buffer name + buffer number

                max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
                -- it can also be a function that returns
                -- the value of `max_length` dynamically.
                filetype_names = {
                    TelescopePrompt = 'Telescope',
                    dashboard = 'Dashboard',
                    packer = 'Packer',
                    fzf = 'FZF',
                    alpha = 'Alpha'
                }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

                buffers_color = {
                    active = 'lualine_b_normal',
                    inactive = 'lualine_b_inactive',
                },

                symbols = {
                    modified = ' ●',      -- Text to show when the buffer is modified
                    alternate_file = '', -- Text to show to identify the alternate file
                    directory =  '',     -- Text to show when the buffer is a directory
                },
            },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
})

