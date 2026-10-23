Lib.packadd {
    src = 'https://github.com/catppuccin/nvim',
    name = 'catppuccin',
    callback = function(p)
        p.setup {
            flavour = 'mocha',
            no_italic = true,
            no_bold = true,
            transparent_background = true,
            term_colors = vim.g.termguicolors,

            custom_highlights = function(colors)
                return {
                    -- mini.pick
                    MiniPickBorderText = { fg = colors.mantle, bg = colors.mantle },
                    MiniPickBorderBusy = { fg = colors.mantle, bg = colors.mantle },
                    MiniPickPromptPrefix = { fg = colors.blue },
                    MiniPickPrompt = { fg = colors.subtext1 },
                    MiniPickMatchCurrent = { fg = colors.none, bg = '#2a2b3c' },

                    -- mini.clue
                    MiniClueTitle = { fg = colors.flamingo, bg = colors.mantle },
                    MiniClueSeparator = { fg = colors.overlay0 },
                    MiniClueNextKey = { fg = colors.blue },
                }
            end,
        }
    end,
}

-- set after all colorschemes have been sourced
local name = vim.g.colorscheme
if name then
    local ok, err = pcall(vim.cmd.colorscheme, name)
    if not ok then
        vim.notify(err, vim.log.levels.WARN)
    end
end
