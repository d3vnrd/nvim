Lib.packadd {
    src = 'https://github.com/stevearc/conform.nvim',
    name = 'conform',
    event = 'BufReadPre',
    callback = function(plugin)
        plugin.setup {
            notify_on_error = false,
            notify_no_formatters = false,

            default_format_opts = {
                -- Use external formatters if configured below, otherwise use LSP formatting.
                --  Set to `false` to disable LSP formatting entirely.
                lsp_format = 'fallback',
            },

            format_on_save = function(bufnr)
                local disable_filetypes = { c = true, cpp = true }
                if disable_filetypes[vim.bo[bufnr].filetype] then
                    return nil
                end

                if not vim.g.autoformat then
                    return nil
                end

                return { timeout_ms = 500 }
            end,

            -- TODO: adjust this list to reflect how i would use
            formatters_by_ft = {
                css = { 'dprint' },
                go = { name = 'gopls', timeout_ms = 500, lsp_format = 'prefer' },
                html = { 'dprint' },
                javascript = { 'dprint' },
                lua = { 'stylua' },
                markdown = { 'dprint' },
                nix = { 'nixfmt' },
                python = { 'ruff' },
                sh = { 'shfmt' },
                typescript = { 'dprint' },
                typst = { 'typstyle' },
                yaml = { 'dprint' },

                -- For filetypes without a formatter:
                ['_'] = { 'trim_whitespace', 'trim_newlines' },
            },
        }

        -- Start auto-formatting by default (disable with user ToggleFormat command)
        vim.g.autoformat = true

        vim.api.nvim_create_user_command('ToggleAutoFormat', function()
            local enabled = vim.g.autoformat
            vim.g.autoformat = not enabled
            vim.notify(string.format('%s auto-format', enabled and 'Disable' or 'Enable'), vim.log.levels.INFO)
        end, {})

        Lib.bind('<leader>fm', function()
            plugin.format { async = true }
        end, 'Format current buffer')
    end,
}
