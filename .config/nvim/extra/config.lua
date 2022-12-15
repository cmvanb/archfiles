-- NOTE: Add to `lua/plugins/config.lua`.

    -- Bufferline
    {
        'akinsho/bufferline.nvim',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            do_load('plugins/bufferline')
        end,
    },
