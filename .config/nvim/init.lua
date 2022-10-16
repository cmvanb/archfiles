--------------------------------------------------------------------------------
-- Neovim configuration
--------------------------------------------------------------------------------

-- Packer's compile target is in `.local/share/nvim`, so we need to include this
-- in the runtimepath to ensure NVIM can autoload Packer.
-- TODO: Make sure this isn't adding duplicates when sourcing.
vim.opt.runtimepath:append(vim.fn.stdpath('data'))

-- Improve startup performance.
require('utils.disable_builtins')

-- Global utils.
require('utils.debug')
require('utils.do_load')
require('utils.reload')

-- Load editor config.
reload('editor.options')
reload('editor.gui')
reload('editor.highlights')
reload('editor.keymaps')

-- Load autocommands.
reload('autocommands')

-- Bootstrap Packer if necessary.
local loader = reload('loader')
loader.init()

