--------------------------------------------------------------------------------
-- Plugin configuration
--------------------------------------------------------------------------------

return {

    -- Packer can manage itself.
    { 'wbthomason/packer.nvim' },

    -- Mini plugins collection.
    {
        'echasnovski/mini.nvim',
        config = function()
            do_load('plugins/mini/comment')
            do_load('plugins/mini/cursorword')
            do_load('plugins/mini/indentscope')
            do_load('plugins/mini/pairs')
        end
    },

    -- View colors in editor.
    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            do_load('plugins/colorizer')
        end
    },

    -- Terminal background fix.
    -- TODO: Plugin should dynamically read terminal and editor background color.
    -- { '~/projects/termbg.nvim' },

    -- Redirect output to scratch buffer.
    { 'sbulav/nredir.nvim' },

    -- Mason is a package manager for LSP tooling such as language servers,
    -- debug servers, linters and formatters.
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({
                ui = {
                    border = 'rounded',
                },
            })
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup()
        end,
    },

    -- Default language server configurations
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('lspconfig')['pyright'].setup({})
            require('lspconfig')['sumneko_lua'].setup({})
        end,
    },

    -- Snippet engine.
    {
        'L3MON4D3/LuaSnip',
        config = function()
            local luasnip = require('luasnip')

            luasnip.setup({
                history = true,
                update_events = 'TextChanged,TextChangedI',
            })
        end,
    },

    -- Various snippets.
    {
        'rafamadriz/friendly-snippets',
        requires = { 'L3MON4D3/LuaSnip' },
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
        end,
    },

    -- Completion.
    {
        'hrsh7th/nvim-cmp',
        requires = { 'L3MON4D3/LuaSnip' },
        config = function()
            do_load('plugins/completion')
        end
    },

    -- various completions
    -- { 'hrsh7th/cmp-buffer' },
    -- { 'hrsh7th/cmp-cmdline' },
    -- { 'hrsh7th/cmp-path' },
    -- { 'hrsh7th/cmp-nvim-lua' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'saadparwaiz1/cmp_luasnip' },

    -- Surround.
    -- sa: add, sd: delete, sr: replace
    -- ib: inner select, ab: outer select (VISUAL mode)
    { 'machakann/vim-sandwich' },

    -- easier digraphs
    -- :UnicodeName
    -- :UnicodeSearch
    -- :UnicodeTable
    -- :Digraphs
    {
        'chrisbra/unicode.vim',
        config = function()
            vim.g.Unicode_no_default_mappings = true
        end,
    },

    -- Jump movement.
    {
        'ggandor/leap.nvim',
        config = function()
            do_load('plugins/leap')
        end
    },

    -- Fuzzy finder.
    {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            do_load('plugins/telescope')
        end
    },

    -- Symbols ❤️
    {
        'nvim-telescope/telescope-symbols.nvim',
    },

    {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            do_load('plugins/lualine')
        end,
    },

    -- Fish syntax highlighting.
    { 'khaveesh/vim-fish-syntax' },

    -- Zig syntax highlighting.
    { 'ziglang/zig.vim' },

}

