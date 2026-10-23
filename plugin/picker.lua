-- NOTE: MiniPick override vim.ui.select by default
Lib.packadd {
    src = 'https://github.com/nvim-mini/mini.pick',
    callback = function(pick)
        pick.setup {
            window = {
                prompt_caret = '█',
                config = {
                    height = 10,
                    width = vim.o.columns - 2,
                    border = 'solid',
                },
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
        Lib.bind('<leader>fk', function()
            extra.pickers.keymaps({ mode = 'all', scope = 'all' }, {
                source = {
                    -- TODO: custom keymaps show
                    show = function(buf_id, items, _)
                        local lines = vim.tbl_map(function(item)
                            return item.text -- reformat here, for example with string.format('%-20s %s', ...)
                        end, items)
                        vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
                    end,
                },
            })
        end, 'Find available keymaps')
    end,
}
