--------------------------------------------------------------------------------
-- Treesitter configuration
--------------------------------------------------------------------------------

require('nvim-treesitter.configs').setup({
    auto_install = true,
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',    -- Mapped to `+`
            node_incremental = 'grn',  -- Mapped to `+`
            node_decremental = 'grm',  -- Mapped to `-`
            scope_incremental = 'grc',
        },
    },
    indent = {
        enable = true
    },
    playground = {
        enable = true,
    }
})

