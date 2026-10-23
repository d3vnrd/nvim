-- TODO: add support for dependencies for async installation
--  - Lazy loading when parent plugin required
--  - Keep a plugin name table to keep track of already loaded plugins
--  - Defer loading plugins with `deps` field using name table as registry to
--    check, pretty much like callstack
--  - Build a dependency graph, by collecting all the specs first, merges them
--    ,and then call vim.pack.add all at once with { load = false }
--  - Separate added/active state with loaded state for garbage collector to work

-- Current workaround: Nested packadd call or Order-dependent packadd call
--  - Silent child error and run parent callback anyway

-- TODO: consider auto call setup if it is a function

---@class PackSpec : vim.pack.Spec
---@field event? vim.api.keyset.events|vim.api.keyset.events[]
---@field pattern? string|string[]
---@field callback? fun(mod: table|boolean)
---@field confirm? boolean
---@field enable? boolean

---@param p PackSpec
return function(p)
    vim.pack.add({ { src = p.src, name = p.name, version = p.version } }, {
        confirm = p.confirm or false, -- skip confirmation by default
        load = function(data)
            if p.enable == false then
                return
            end

            local setup = function()
                vim.cmd.packadd(data.spec.name)

                if not p.callback then
                    return
                end

                local requirable, mod = pcall(require, data.spec.name)
                local ok, err = pcall(p.callback, requirable and mod or {})
                if not ok then
                    vim.notify(err, vim.log.levels.ERROR)
                end
            end

            if p.event then
                vim.api.nvim_create_autocmd(p.event, {
                    pattern = p.pattern,
                    once = true,
                    callback = setup,
                })
            else
                setup()
            end
        end,
    })
end
