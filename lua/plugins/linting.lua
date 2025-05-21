return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
        require("lint").linters_by_ft = {
            dockerfile = { "hadolint" },
            lua = { "selene" },
        }
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                if vim.opt_local.modifiable:get() then
                    require("lint").try_lint()
                end
            end,
        })
    end,
}
