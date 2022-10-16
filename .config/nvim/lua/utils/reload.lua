--------------------------------------------------------------------------------
-- Reload lua module
--------------------------------------------------------------------------------

function _G.reload(m)
    -- Clear package from loaded and global tables.
    package.loaded[m] = nil
    _G[m] = nil

    -- Require it again and return.
    local ok, module = pcall(require, m)
    if not ok then
        error('Failed to reload lua module `' .. m .. '`.')
    end

    return module
end

return reload

