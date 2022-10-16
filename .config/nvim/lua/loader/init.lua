--------------------------------------------------------------------------------
-- Plugin loader
--
-- Bootstraps packer if necessary.
-- Loads plugin configuration from `lua/plugins/config`.
-- Sets up automatic reloading of plugin configuration.
-- Runs Packer (Sync, Clean, Reset, Install, Compile) when needed.
--
-- TODO: Hold a reference to a loaded instance of packer (reduce pcalls).
--------------------------------------------------------------------------------

-- Constants
--------------------------------------------------------------------------------

local packer_data_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local plugins_config_path = vim.fn.stdpath('config') .. '/lua/plugins'

-- Private functions
--------------------------------------------------------------------------------

local function clone_packer()
    vim.fn.delete(packer_data_path, 'rf')

    vim.fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim', '--depth', '1',
        packer_data_path,
    })

    vim.cmd('packadd packer.nvim')

    local ok, packer = pcall(require, 'packer')
    if not ok then
        error('Packer failed to clone to: `' .. packer_data_path .. '`.')
        return
    end

    return packer
end

local function load_plugin_config()
    local packer_ok, packer = pcall(require, 'packer')
    if not packer_ok then
        error('Packer not available, unable to load plugin configs.')
        return
    end

    -- Clear out managed plugins.
    packer.reset()

    -- Refresh the config.
    local config = reload('plugins.config')

    local config_ok, _ = xpcall(function()
        for _, plugin in ipairs(config) do
            -- Pass plugin configuration to Packer.
            packer.use(plugin)
        end
    end, debug.traceback)

    if not config_ok then
        error('Unable to load plugin configs')
        return
    end
end

local function clean_plugins(callback)
    local ok, packer = pcall(require, 'packer')
    if not ok then
        error('Packer not available, unable to clean plugins.')
        return
    end

    vim.api.nvim_create_autocmd('User', {
        pattern = 'PackerComplete',
        once = true,
        callback = callback,
    })

    packer.clean()
end

local function install_plugins(callback)
    local ok, packer = pcall(require, 'packer')
    if not ok then
        error('Packer not available, unable to install plugins.')
        return
    end

    vim.api.nvim_create_autocmd('User', {
        pattern = 'PackerComplete',
        once = true,
        callback = callback,
    })

    packer.install()
end

local function compile_packer(callback)
    local ok, packer = pcall(require, 'packer')
    if not ok then
        error('Packer not available, unable to compile plugins.')
        return
    end

    vim.api.nvim_create_autocmd('User', {
        pattern = 'PackerCompileDone',
        once = true,
        callback = callback,
    })

    packer.compile()
end

local function reload_plugins()
    load_plugin_config()

    clean_plugins(function()
        install_plugins(function()
            compile_packer(function()
                vim.notify('Packer compiled.')
            end)
        end)
    end)
end

-- Public interface
--------------------------------------------------------------------------------

local Loader = {}

function Loader.init()
    local bootstrapping = false

    -- Clone Packer if necessary.
    local ok, packer = pcall(require, 'packer')
    if not ok then
        vim.notify('Packer not installed, bootstrapping...')

        packer = clone_packer()
        bootstrapping = true
    end

    -- Initialize Packer.
    local packer_config = reload('loader.config')
    packer.init(packer_config)

    -- Load plugin configuration.
    load_plugin_config()

    -- Sync if necesssary.
    if bootstrapping then
        vim.api.nvim_create_autocmd('User', {
            pattern = 'PackerComplete',
            once = true,
            callback = function()
                -- Ensure we can use our packages immediately.
                vim.cmd('packloadall!')

                -- Still, a restart is probably for the best. There may be some
                -- side effects to using installed plugins immediately.
                vim.notify('Packer synced, bootstrapping complete. Please restart NVIM.')
            end,
        })

        packer.sync()
    end

    -- Auto reload plugins if configuration changes.
    local augroup = vim.api.nvim_create_augroup("ReloadPluginsConfig", { clear = true })
    vim.api.nvim_create_autocmd('BufWritePost', {
        group = augroup,
        pattern = plugins_config_path .. '/*.lua',
        callback = function()
            reload_plugins()
        end,
    })
end

return Loader

