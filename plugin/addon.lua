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
                delay = 0,
                scroll_down = '<C-d>',
                scroll_up = '<C-u>',
                config = function(bufnr)
                    local editor_height = vim.o.lines - vim.o.cmdheight - 1

                    -- screen row of the current cursor, 1-indexed
                    local cursor_row = vim.fn.screenpos(
                        vim.api.nvim_get_current_win(),
                        vim.api.nvim_win_get_cursor(0)[1],
                        vim.api.nvim_win_get_cursor(0)[2] + 1
                    ).row

                    -- put the clue window opposite the cursor vertically
                    local swap = cursor_row > editor_height / 2

                    -- dynamic max width
                    local max_width = 0
                    for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
                        max_width = math.max(max_width, vim.fn.strdisplaywidth(line))
                    end

                    max_width = max_width + 1 -- keep some right padding

                    return {
                        anchor = swap and 'NW' or 'SW', -- anchor at top/bot left
                        row = swap and 0 or editor_height,
                        width = math.min(70, max_width), -- capped at 70
                        height = math.min(vim.api.nvim_buf_line_count(bufnr), 10),
                    }
                end,
            },
        }
    end,
}
