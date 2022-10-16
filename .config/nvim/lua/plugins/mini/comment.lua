--------------------------------------------------------------------------------
-- Mini comment plugin
--------------------------------------------------------------------------------

require('mini.comment').setup({
    mappings = {
        comment_line = 'gcc',
        -- TODO: Test whether these mappings work as desired.
        comment = 'gc',
        textobject = 'gc',
    },
})

