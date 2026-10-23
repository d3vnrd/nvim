local base = ...

---@class NvLib
---@field packadd fun(p: PackSpec)
local lib = {}

---@param desc string
lib.augroup = function(desc)
    return vim.api.nvim_create_augroup('user/' .. desc, { clear = true })
end

---@param keys string
---@param func string|function
---@param opts? string|vim.keymap.set.Opts
---@param mode? string|string[]
lib.bind = function(keys, func, opts, mode)
    if type(opts) == 'string' then
        opts = { desc = opts }
    end

    vim.keymap.set(mode or 'n', keys, func, opts)
end

-- TODO: might remove this
---@param editor_height? integer
---@return boolean
lib.cursor_in_lower_half = function(editor_height)
    editor_height = editor_height or lib.editor_height()
    local win = vim.api.nvim_get_current_win()
    local row, col = unpack(vim.api.nvim_win_get_cursor(win))
    local screen_row = vim.fn.screenpos(win, row, col + 1).row
    return screen_row > editor_height / 2
end

-- TODO: might remove this
---@return integer
lib.editor_height = function()
    return vim.o.lines - vim.o.cmdheight - 1
end

lib.packadd = require(base .. '.packadd')

return lib
