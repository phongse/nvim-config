local M = {}

function M.keymap(mode, lhs, rhs, desc, opts)
    local _opts = opts or {}
    _opts.silent = _opts.silent ~= false
    _opts.desc = desc
    vim.keymap.set(mode, lhs, rhs, _opts)
end

function M.code_action(action)
    return function()
        vim.lsp.buf.code_action({
            apply = true,
            context = {
                only = { action },
                diagnostics = {},
            },
        })
    end
end

return M
