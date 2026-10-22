vim.loader.enable()

vim.g.have_nerd_font = true
vim.g.nerd_font_variant = 'mono'
vim.g.colorscheme = 'catppuccin-nvim'

_G.Lib = require 'lib'

require 'options'
require 'colorscheme'
require 'commands'
require 'keymaps'
require 'lsp-config'
