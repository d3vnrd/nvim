--- Text Editing ---
Lib.packadd {
    -- Better Around/Inside textobjects. Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    src = 'https://github.com/nvim-mini/mini.ai',
    event = { 'BufNewFile', 'BufReadPre' },
    callback = function(ai)
        ai.setup {
            -- NOTE: Avoid conflicts with the built-in incremental selection
            --  mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
            mappings = {
                around_next = 'aa',
                inside_next = 'ii',
            },
            n_lines = 500,
        }
    end,
}

Lib.packadd {
    src = 'https://github.com/nvim-mini/mini.pairs',
    event = { 'BufNewFile', 'BufReadPre' },
    callback = function(pairs)
        pairs.setup()
    end,
}

Lib.packadd {
    -- Add/delete/replace surroundings (brackets, quotes, etc.). Examples:
    --  - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    --  - sd'   - [S]urround [D]elete [']quotes
    --  - sr)'  - [S]urround [R]eplace [)] [']
    src = 'https://github.com/nvim-mini/mini.surround',
    event = { 'BufNewFile', 'BufReadPre' },
    callback = function(surround)
        surround.setup()
    end,
}

--- General Workflow ---
Lib.packadd {
    src = 'https://github.com/nvim-mini/mini.clue',
    event = 'UIEnter',
    callback = function(clue)
        clue.setup {
            triggers = {
                -- Leader triggers
                { mode = { 'n', 'x' }, keys = '<Leader>' },

                -- `[` and `]` keys
                { mode = 'n', keys = '[' },
                { mode = 'n', keys = ']' },

                -- Built-in completion
                { mode = 'i', keys = '<C-x>' },

                -- `g` key
                { mode = { 'n', 'x' }, keys = 'g' },

                -- Marks
                { mode = { 'n', 'x' }, keys = "'" },
                { mode = { 'n', 'x' }, keys = '`' },

                -- Registers
                { mode = { 'n', 'x' }, keys = '"' },
                { mode = { 'i', 'c' }, keys = '<C-r>' },

                -- Window commands
                { mode = 'n', keys = '<C-w>' },

                -- `z` key
                { mode = { 'n', 'x' }, keys = 'z' },
            },

            clues = {
                { mode = { 'n', 'x' }, keys = '<leader>f', desc = '+find' },

                -- Builtins
                clue.gen_clues.builtin_completion(),
                clue.gen_clues.g(),
                clue.gen_clues.marks(),
                clue.gen_clues.registers(),
                clue.gen_clues.windows(),
                clue.gen_clues.z(),
            },

            window = {
                delay = 500,
                scroll_down = '<C-d>',
                scroll_up = '<C-u>',
                config = {
                    width = vim.o.columns - 2,
                    height = 5,
                    border = vim.o.winborder,
                    title_pos = 'center',
                },
            },
        }
    end,
}
