--------------------------------------------------------------------------------
-- Neovim plugins
--------------------------------------------------------------------------------

-- Plugin manager configuration
--------------------------------------------------------------------------------

local packer = require('packer')

packerConfig = {
    display = {
        -- Use floating window
        open_fn = function()
            return require('packer.util').float({ border = 'rounded' })
        end,
    }
}

return packer.startup({ function()

-- General
--------------------------------------------------------------------------------

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- mini plugins collection
    use 'echasnovski/mini.nvim'

-- Package management
--------------------------------------------------------------------------------

    -- Mason is a package manager for LSP tooling such as language servers, debug servers, linters and formatters.
    use 'williamboman/mason.nvim'
    require('mason').setup()

-- Appearance
--------------------------------------------------------------------------------

    -- view colors in editor
    use 'norcalli/nvim-colorizer.lua'
    require('colorizer').setup()

    -- terminal background fix
    -- TODO: Plugin should dynamically read terminal and editor background color.
    -- use '~/projects/termbg.nvim'

-- Commands
--------------------------------------------------------------------------------

    -- Redirect output to scratch buffer
    use 'sbulav/nredir.nvim'

-- Completion
--------------------------------------------------------------------------------

    -- snippet engine
    use 'L3MON4D3/LuaSnip'
    local luasnip = require('luasnip')

    luasnip.setup({
        history = true,
        update_events = 'TextChanged,TextChangedI',
    })

    -- various snippets
    use 'rafamadriz/friendly-snippets'
    require('luasnip.loaders.from_vscode').lazy_load()

    -- completion plugin
    use 'hrsh7th/nvim-cmp'
    local cmp = require('cmp')

    -- various completions
    -- use 'hrsh7th/cmp-buffer'
    -- use 'hrsh7th/cmp-cmdline'
    -- use 'hrsh7th/cmp-path'
    -- use 'hrsh7th/cmp-nvim-lua'
    -- use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
        mapping = cmp.mapping.preset.insert({
            -- ['<C-k>'] = cmp.mapping.scroll_docs(-4),
            -- ['<C-j>'] = cmp.mapping.scroll_docs(4),
            -- ['<C-Space>'] = cmp.mapping.complete(),
            -- ['<C-x>'] = cmp.mapping.abort(),

            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),
            -- TODO: Fix the shift-tab mapping not working.
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            -- NOTE: Inlcuded for consistency with fish shell. Ideally we want to change fish shell completion bindings.
            ['<Right>'] = cmp.mapping.confirm({ select = true }),
        }),

        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        sources = {
            -- { name = 'buffer' },
            -- { name = 'cmdline' },
            -- { name = 'path' },
            -- { name = 'nvim_lua' },
            -- { name = 'nvim_lsp' },
            { name = 'luasnip' },
        },
        window = {
            completion = {
                border = 'none',
                winhighlight = 'Normal:CmpMenuBackground,CursorLine:CmpMenuSelect',
            },
        },
    })

-- LSP
--------------------------------------------------------------------------------

    use 'neovim/nvim-lspconfig'

-- Editing
--------------------------------------------------------------------------------

    -- surround
    -- sa: add, sd: delete, sr: replace
    -- ib: inner select, ab: outer select (VISUAL mode)
    use 'machakann/vim-sandwich'

    -- easier digraphs
    -- :UnicodeName
    -- :UnicodeSearch
    -- :UnicodeTable
    -- :Digraphs
    use ({
        'chrisbra/unicode.vim',
        config = function()
            vim.g.Unicode_no_default_mappings = true
        end,
    })

    -- commenting
    require('mini.comment').setup({
        mappings = {
            comment = 'gc',
            comment_line = 'gcc',
            textobject = 'gc',
        },
    })

    -- pairs
    require('mini.pairs').setup({
        modes = { insert = true, command = false, terminal = false },

        mappings = {
            ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
            ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
            ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },
            ['<'] = { action = 'open', pair = '<>', neigh_pattern = '[^\\].' },

            [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
            [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
            ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
            ['>'] = { action = 'close', pair = '<>', neigh_pattern = '[^\\].' },

            ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
            ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
            ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
        },
    })

    -- Symbols ❤️
    use 'nvim-telescope/telescope-symbols.nvim'

-- Navigation
--------------------------------------------------------------------------------

    -- highlight all occurrences of word under cursor
    require('mini.cursorword').setup({
        delay = 0,
    })

    -- jump movement
    use 'ggandor/leap.nvim'

    -- show scope of current indent
    require('mini.indentscope').setup({
        draw = {
            delay = 100,
            animation = require('mini.indentscope')
                .gen_animation('cubicInOut', { duration = 15 }),
        },

        mappings = {
            object_scope = 'ii',
            object_scope_with_border = 'ai',
            goto_top = '[i',
            goto_bottom = ']i',
        },

        options = {
            border = 'both',
            indent_at_cursor = true,
            try_as_border = false,
        },

        symbol = '╎',
    })

-- Search
--------------------------------------------------------------------------------

    -- fuzzy finder
    use ({
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    })

    require('telescope').setup({
        defaults = {
            vimgrep_arguments = {
                'rg',
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case',
                '--no-ignore',
                '--hidden',
            },
            mappings = {
                i = {
                    ['<C-n>'] = false,
                    ['<C-p>'] = false,
                    ['<C-j>'] = require('telescope.actions').move_selection_next,
                    ['<C-k>'] = require('telescope.actions').move_selection_previous,
                    ['<Esc>'] = require('telescope.actions').close,
                },
            },
        },
    })

-- Status line
--------------------------------------------------------------------------------

    use ({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    })

    -- TODO: Configure lualine.
    -- require('lualine').setup()

-- Syntax
--------------------------------------------------------------------------------

    -- fish syntax highlighting
    use 'khaveesh/vim-fish-syntax'

    -- zig syntax highlighting
    use 'ziglang/zig.vim'

--------------------------------------------------------------------------------

end,
config = packerConfig })

