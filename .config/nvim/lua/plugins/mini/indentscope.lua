--------------------------------------------------------------------------------
-- Mini indentscope plugin
--
-- Show scope of current indent.
--------------------------------------------------------------------------------

local indentscope = require('mini.indentscope')

indentscope.setup({
    draw = {
        delay = 200,
        animation = indentscope.gen_animation.cubic({ easing = 'in-out', duration = 15 }),
    },

    mappings = {
        object_scope = 'ii',
        object_scope_with_border = 'ai',
        goto_top = '[i',
        goto_bottom = ']i',
    },

    options = {
        border = 'both',
        indent_at_cursor = true,
        try_as_border = false,
    },

    symbol = '╎',
})

