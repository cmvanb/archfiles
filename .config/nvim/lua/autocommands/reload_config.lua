--------------------------------------------------------------------------------
-- Reload configuration changes.
--------------------------------------------------------------------------------

local StringUtils = require('utils/string')

local config_path = vim.fn.stdpath('config')
local augroup = vim.api.nvim_create_augroup("ReloadConfig", { clear = true })

vim.api.nvim_create_autocmd('BufWritePost', {
    group = augroup,
    pattern = config_path .. '/*.lua',
    callback = function()
        local buffer_path = vim.api.nvim_buf_get_name(0)

        -- Must be in `/lua` directory...
        if (StringUtils.contains(buffer_path, '/lua')
            -- But not in `/lua/plugins` because plugin configuration is already
            -- handled by another autocommand.
            and not StringUtils.contains(buffer_path, '/lua/plugins'))
            -- Or it can be the root `init.lua`.
            or buffer_path == config_path .. '/init.lua' then

            -- Reload.
            vim.cmd('source ' .. buffer_path)

            vim.defer_fn(function()
                vim.notify('Sourced `' .. buffer_path .. '`.')
            end, 1)
        end
    end,
})


