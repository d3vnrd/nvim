vim.loader.enable()

vim.g.have_nerd_font = true
vim.g.nerd_font_variant = 'normal'
vim.g.colorscheme = 'catppuccin'

_G.Lib = require 'lib'

require 'options'
require 'commands'
require 'keymaps'
require 'lsp-config'
