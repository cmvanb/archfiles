--------------------------------------------------------------------------------
-- Colorizer configuration
--------------------------------------------------------------------------------

local colorizer = require('colorizer')
colorizer.setup()

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        colorizer.attach_to_buffer(0)
    end,
})

