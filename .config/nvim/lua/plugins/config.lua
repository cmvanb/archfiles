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

    -- TODO: Restore LSP.
    -- Mason is a package manager for LSP tooling such as language servers,
    -- debug servers, linters and formatters.
    -- {
    --     'williamboman/mason.nvim',
    --     config = function()
    --         require('mason').setup()
    --     end,
    -- },
    -- {
    --     'williamboman/mason-lspconfig.nvim',
    --     config = function()
    --         require('mason-lspconfig').setup()
    --     end,
    -- },
    -- -- Default language server configurations
    -- {
    --     'neovim/nvim-lspconfig',
    --     config = function()
    --         require('lspconfig')['pyright'].setup({})
    --     end,
    -- },

    -- TODO: Restore completion.
    -- -- snippet engine
    -- {
    --     'L3MON4D3/LuaSnip',
    --     config = function()
    --         -- code
    --     end,
    -- },
    -- local luasnip = require('luasnip')
    --
    -- luasnip.setup({
    --     history = true,
    --     update_events = 'TextChanged,TextChangedI',
    -- })
    --
    -- -- various snippets
    -- { 'rafamadriz/friendly-snippets' },
    -- require('luasnip.loaders.from_vscode').lazy_load()
    --
    -- -- completion plugin
    -- { 'hrsh7th/nvim-cmp' },
    -- local cmp = require('cmp')
    --
    -- -- various completions
    -- -- { 'hrsh7th/cmp-buffer' },
    -- -- { 'hrsh7th/cmp-cmdline' },
    -- -- { 'hrsh7th/cmp-path' },
    -- -- { 'hrsh7th/cmp-nvim-lua' },
    -- { 'hrsh7th/cmp-nvim-lsp' },
    -- { 'saadparwaiz1/cmp_luasnip' },
    --
    -- local function has_words_before()
    --     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    -- end
    --
    -- cmp.setup({
    --     mapping = cmp.mapping.preset.insert({
    --         -- ['<C-k>'] = cmp.mapping.scroll_docs(-4),
    --         -- ['<C-j>'] = cmp.mapping.scroll_docs(4),
    --         -- ['<C-Space>'] = cmp.mapping.complete(),
    --         -- ['<C-x>'] = cmp.mapping.abort(),
    --
    --         ['<Tab>'] = cmp.mapping(function(fallback)
    --             if cmp.visible() then
    --                 cmp.select_next_item()
    --             elseif luasnip.expand_or_jumpable() then
    --                 luasnip.expand_or_jump()
    --             elseif has_words_before() then
    --                 cmp.complete()
    --             else
    --                 fallback()
    --             end
    --         end, { 'i', 's' }),
    --         -- TODO: Fix the shift-tab mapping not working.
    --         ['<S-Tab>'] = cmp.mapping(function(fallback)
    --             if cmp.visible() then
    --                 cmp.select_prev_item()
    --             elseif luasnip.jumpable(-1) then
    --                 luasnip.jump(-1)
    --             else
    --                 fallback()
    --             end
    --         end, { 'i', 's' }),
    --         ['<CR>'] = cmp.mapping.confirm({ select = true }),
    --         -- NOTE: Inlcuded for consistency with fish shell. Ideally we want to change fish shell completion bindings.
    --         ['<Right>'] = cmp.mapping.confirm({ select = true }),
    --     }),
    --
    --     snippet = {
    --         expand = function(args)
    --             require('luasnip').lsp_expand(args.body)
    --         end,
    --     },
    --     sources = {
    --         -- { name = 'buffer' },
    --         -- { name = 'cmdline' },
    --         -- { name = 'path' },
    --         -- { name = 'nvim_lua' },
    --         -- { name = 'nvim_lsp' },
    --         { name = 'luasnip' },
    --     },
    --     window = {
    --         completion = {
    --             border = 'none',
    --             winhighlight = 'Normal:CmpMenuBackground,CursorLine:CmpMenuSelect',
    --         },
    --     },
    -- })

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

    -- {
    --     'nvim-lualine/lualine.nvim',
    --     requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    --     config = function()
    --         -- TODO: Configure lualine.
    --         -- require('lualine').setup()
    --     end,
    -- }

    -- Fish syntax highlighting.
    { 'khaveesh/vim-fish-syntax' },

    -- Zig syntax highlighting.
    { 'ziglang/zig.vim' },

}

