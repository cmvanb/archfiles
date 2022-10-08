--------------------------------------------------------------------------------
-- Neovim configuration
--------------------------------------------------------------------------------

-- Helpers
--------------------------------------------------------------------------------

local cmd = vim.cmd
local opt = vim.opt
local api = vim.api
local fn = vim.fn
local g = vim.g

-- Automatic reload
--------------------------------------------------------------------------------

-- Reload configuration files automatically when edited. Also triggers package
-- manager compile step.
cmd([[
    augroup ReloadInit
        autocmd!
        autocmd BufWritePost init.lua source <afile>
    augroup end
    augroup ReloadSettings
        autocmd!
        autocmd BufWritePost settings.lua source <afile>
    augroup end
    augroup ReloadGUI
        autocmd!
        autocmd BufWritePost gui.lua source <afile>
    augroup end
    augroup ReloadKeybinds
        autocmd!
        autocmd BufWritePost keybinds.lua source <afile>
    augroup end
    augroup ReloadHighlights
        autocmd!
        autocmd BufWritePost highlights.lua source <afile>
    augroup end
    augroup ReloadPlugins
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

-- Configuration modules
--------------------------------------------------------------------------------

require('settings')
require('gui')
require('keybinds')
require('highlights')
require('plugins')

