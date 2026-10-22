Lib.packadd {
    src = 'https://github.com/catppuccin/nvim',
    name = 'catppuccin',
    callback = function(p)
        p.setup {
            flavour = 'mocha',
            transparent_background = true,
            term_colors = vim.g.termguicolors,
            no_italic = true,
            no_bold = true,
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
