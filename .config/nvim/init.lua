--------------------------------------------------------------------------------
-- Neovim configuration
--------------------------------------------------------------------------------

-- Automatic reload
--------------------------------------------------------------------------------

-- Reload configuration files automatically when edited. Also triggers package
-- manager compile step.
vim.cmd([[
    augroup ReloadInit
        autocmd!
        autocmd BufWritePost ~/.config/nvim/init.lua source <afile>
    augroup end
    augroup ReloadSettings
        autocmd!
        autocmd BufWritePost ~/.config/nvim/lua/settings.lua source <afile>
    augroup end
    augroup ReloadGUI
        autocmd!
        autocmd BufWritePost ~/.config/nvim/lua/gui.lua source <afile>
    augroup end
    augroup ReloadKeybinds
        autocmd!
        autocmd BufWritePost ~/.config/nvim/lua/keybinds.lua source <afile>
    augroup end
    augroup ReloadHighlights
        autocmd!
        autocmd BufWritePost ~/.config/nvim/lua/highlights.lua source <afile>
    augroup end
    augroup ReloadPlugins
        autocmd!
        autocmd BufWritePost ~/.config/nvim/lua/plugins.lua source <afile> | PackerCompile
    augroup end
]])

-- Configuration modules
--------------------------------------------------------------------------------

require('settings')
require('gui')
require('keybinds')
require('highlights')
require('plugins')

