--------------------------------------------------------------------------------
-- Telescope configuration
--------------------------------------------------------------------------------

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--no-ignore',
            '--hidden',
        },
        mappings = {
            i = {
                ['<C-n>'] = actions.select_vertical,
                ['<C-p>'] = false,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
                ['<Esc>'] = actions.close,
            },
        },
    },
})

