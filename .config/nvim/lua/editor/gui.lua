--------------------------------------------------------------------------------
-- Neovim GUI configuration
--------------------------------------------------------------------------------

if vim.g.neovide ~= nil then
    local theme = require('system.theme')

    vim.opt.guifont = theme.font('font_mono')

    -- TODO: Get Cursor highlighting working in Neovide.
    vim.cmd('set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20') 

    vim.g.neovide_cursor_vfx_mode = 'sonicboom'
end

