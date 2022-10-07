--------------------------------------------------------------------------------
-- Neovim GUI configuration
--------------------------------------------------------------------------------

-- Helpers
local cmd = vim.cmd
local opt = vim.opt
local api = vim.api
local fn = vim.fn
local g = vim.g

-- Neovide
--------------------------------------------------------------------------------

if g.neovide ~= nil then
    opt.guifont = 'Iosevka Nerd Font Mono:h12'

    -- TODO: Get Cursor highlighting working in Neovide.
    cmd('set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20') 

    g.neovide_cursor_vfx_mode = 'sonicboom'
end

