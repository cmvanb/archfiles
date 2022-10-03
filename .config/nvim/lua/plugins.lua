--------------------------------------------------------------------------------
-- NVIM plugins configuration --
--
-- This file is called from init.lua with `lua.require('plugins')`
--------------------------------------------------------------------------------

local packer = require('packer')

-- Plugin manager configuration
--------------------------------------------------------------------------------

packerConfig = {
    display = {
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

    -- useful lua functions
    -- NOTE: Some plugins may depend on this.
    use 'nvim-lua/plenary.nvim'

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

    -- various snippets
    use 'rafamadriz/friendly-snippets'

    -- completion plugin
    use 'hrsh7th/nvim-cmp'

    -- various completions
    use 'hrsh7th/cmp-buffer'
    -- use 'hrsh7th/cmp-cmdline'
    -- use 'hrsh7th/cmp-path'
    -- use 'hrsh7th/cmp-nvim-lua'
    -- use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'

    local cmp = require('cmp')

    cmp.setup({
        mapping = cmp.mapping.preset.insert({
            -- ['<C-k>'] = cmp.mapping.scroll_docs(-4),
            -- ['<C-j>'] = cmp.mapping.scroll_docs(4),
            -- ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-x>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        sources = {
            { name = 'buffer' },
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

-- Navigation
--------------------------------------------------------------------------------

    -- edgemotion
    use 'haya14busa/vim-edgemotion'

    -- highlight all occurrences of word under cursor
    require('mini.cursorword').setup({
        delay = 0,
    })

    -- jump movement
    -- TODO: Decide between hop and mini.jump2d.
    use 'phaazon/hop.nvim'

    require('hop').setup({
        quit_key = '<esc>',
    })

    -- require('mini.jump2d').setup({
    --     -- Label optimization based on home row keys.
    --     labels = 'fjdksla;ghvmc-bnrueiwoqpty',
    --
    --     -- Module mappings. Use `''` (empty string) to disable one.
    --     mappings = {
    --         start_jumping = '<leader>f',
    --     }
    -- })

    -- show scope of current indent
    require('mini.indentscope').setup({
        draw = {
            delay = 0,
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

        -- NOTE: By default, the highlight links to Delimiter.
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

