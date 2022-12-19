local persistence = require('persistence')

return persistence.setup({
    -- directory where session files are saved
    dir = vim.fn.expand(vim.fn.stdpath('data') .. '/sessions/'),
    -- sessionoptions used for saving
    options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
})
