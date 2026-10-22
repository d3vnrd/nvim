local bind = Lib.bind

bind('<Esc>', vim.cmd.nohlsearch, 'Remove highlight after search')
bind(' ', '<nop>', { silent = true }, { 'n', 'v' })

-- Seamless wind navigation
bind('<C-h>', ':wincmd h<cr>', { desc = 'Move focus to the left window', silent = true })
bind('<C-j>', ':wincmd j<cr>', { desc = 'Move focus to the lower window', silent = true })
bind('<C-k>', ':wincmd k<cr>', { desc = 'Move focus to the upper window', silent = true })
bind('<C-l>', ':wincmd l<cr>', { desc = 'Move focus to the right window', silent = true })

-- Better movement with word wrap
bind('k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
bind('j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
