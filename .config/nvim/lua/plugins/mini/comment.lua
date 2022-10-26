--------------------------------------------------------------------------------
-- Mini comment plugin
--------------------------------------------------------------------------------

require('mini.comment').setup({
    mappings = {
        -- NOTE: <C-_> actually maps <C-/>
        -- Toggle comment on selection (VISUAL) or current line (NORMAL)
        comment = '<C-_>',
        -- Toggle comment on current line
        comment_line = '<C-_>',
    },
})

