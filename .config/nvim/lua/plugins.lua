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
    -- NOTE: Not needed when running in wezterm.
    -- use '~/projects/termbg.nvim'

-- Commands
--------------------------------------------------------------------------------

    -- Redirect output to scratch buffer
    use 'sbulav/nredir.nvim'

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
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
            -- Toggle comment (like `gcip` - comment inner paragraph) for both
            -- Normal and Visual modes
            comment = 'gc',
            -- Toggle comment on current line
            comment_line = 'gcc',
            -- Define 'comment' textobject (like `dgc` - delete whole comment block)
            textobject = 'gc',
        },
    })

    -- pairs
    require('mini.pairs').setup({
        -- In which modes mappings from this `config` should be created
        modes = { insert = true, command = false, terminal = false },

        -- Global mappings. Each right hand side should be a pair information, a
        -- table with at least these fields (see more in |MiniPairs.map|):
        -- - <action> - one of 'open', 'close', 'closeopen'.
        -- - <pair> - two character string for pair to be used.
        -- By default pair is not inserted after `\`, quotes are not recognized by
        -- `<CR>`, `'` does not insert pair after a letter.
        -- Only parts of tables can be tweaked (others will use these defaults).
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

-- Git
--------------------------------------------------------------------------------

    use 'airblade/vim-gitgutter'

-- LSP
--------------------------------------------------------------------------------

    use 'neovim/nvim-lspconfig'

-- Navigation
--------------------------------------------------------------------------------

    -- edgemotion
    use 'haya14busa/vim-edgemotion'

    -- highlight all occurrences of word under cursor
    require('mini.cursorword').setup({
        -- Delay (in ms) between when cursor moved and when highlighting appeared
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
            -- Delay (in ms) between event and start of drawing scope indicator.
            delay = 0,

            -- Animation rule for scope's first drawing. A function which, given next
            -- and total step numbers, returns wait time (in ms). See
            -- |MiniIndentscope.gen_animation()| for builtin options. To not use
            -- animation, supply `require('mini.indentscope').gen_animation('none')`.
            animation = require('mini.indentscope')
            .gen_animation('cubicInOut', { duration = 15 }),
        },

        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
            -- Textobjects
            object_scope = 'ii',
            object_scope_with_border = 'ai',

            -- Motions (jump to respective border line; if not present - body line)
            goto_top = '[i',
            goto_bottom = ']i',
        },

        -- Options which control computation of scope. Buffer local values can be
        -- supplied in buffer variable `vim.b.miniindentscope_options`.
        options = {
            -- Type of scope's border: which line(s) with smaller indent to
            -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
            border = 'both',

            -- Whether to use cursor column when computing reference indent. Useful to
            -- see incremental scopes with horizontal cursor movements.
            indent_at_cursor = true,

            -- Whether to first check input line to be a border of adjacent scope.
            -- Use it if you want to place cursor on function header to get scope of
            -- its body.
            try_as_border = false,
        },

        -- NOTE: By default, the highlight links to Delimter.
        -- Which character to use for drawing scope indicator.
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
            -- Arguments for Telescope.live_grep picker.
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

