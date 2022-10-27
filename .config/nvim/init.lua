--------------------------------------------------------------------------------
-- Neovim configuration
--------------------------------------------------------------------------------

-- Packer's compile target is in `.local/share/nvim`, so we need to include this
-- in the runtimepath to ensure NVIM can autoload Packer.
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

-- Load autocommands.
reload('autocommands')

-- Load plugins. Will bootstrap Packer if necessary.
reload('loader')
Loader.init()

-- Some key mappings may depend on plugins.
reload('editor.keymaps')

