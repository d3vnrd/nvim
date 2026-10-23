Lib.packadd {
    src = 'https://github.com/nvim-mini/mini.statusline',
    event = 'UIEnter',
    callback = function(st)
        st.setup { use_icons = vim.g.have_nerd_font }
    end,
}

Lib.packadd {
    src = 'https://github.com/nvim-mini/mini.icons',
    event = 'UIEnter',
    callback = function(icons)
        if vim.g.have_nerd_font then
            icons.setup()
        end
    end,
}
