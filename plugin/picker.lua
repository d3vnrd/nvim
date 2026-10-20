Lib.packadd {
    src = 'https://github.com/nvim-mini/mini.pick',
    callback = function(pick)
        pick.setup {
            window = {
                prompt_caret = '█',
                config = function()
                    return {
                        height = 10,
                        width = vim.api.nvim_win_get_width(0),
                        border = {
                            ' ', -- top-left-corner
                            ' ', -- top
                            ' ', -- top-right-corner
                            ' ', -- right
                            '', -- bottom-right-corner
                            '', -- bottom
                            '', -- bottom-left-corner
                            ' ',
                        },
                    }
                end,
            },
        }

        Lib.bind('<leader>fb', pick.builtin.buffers, 'Find opened buffers')
        Lib.bind('<leader>ff', pick.builtin.files, 'Find files')
        Lib.bind('<leader>fg', pick.builtin.grep_live, 'Live grep for words')
        Lib.bind('<leader>fh', pick.builtin.help, 'Find help pages')
        Lib.bind('<leader><leader>', function()
            local ok, _ = pcall(pick.builtin.resume)
            if not ok then
                return
            end
        end, 'Resume previous picker')
    end,
}

-- Extra picker options
Lib.packadd {
    src = 'https://github.com/nvim-mini/mini.extra',
    callback = function(extra)
        extra.setup {}

        Lib.bind('<leader>fc', extra.pickers.commands, 'Find available commands')
        Lib.bind('<leader>fe', extra.pickers.explorer, 'Explore current directory and open file')
        Lib.bind('<leader>fk', extra.pickers.keymaps, 'Find available keymaps')
    end,
}
