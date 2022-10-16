--------------------------------------------------------------------------------
-- Neovim GUI configuration
--------------------------------------------------------------------------------

if vim.g.neovide ~= nil then
    vim.opt.guifont = 'Iosevka Nerd Font Mono:h12'

    -- TODO: Get Cursor highlighting working in Neovide.
    vim.cmd('set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20') 

    vim.g.neovide_cursor_vfx_mode = 'sonicboom'
end

