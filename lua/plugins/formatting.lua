return {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>bf",
            function()
                require("conform").format({ async = true }, function()
                    vim.cmd("write")
                end)
            end,
            mode = "n",
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            json = { "biome" },
            lua = { "stylua" },
            python = { "ruff_format" },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
    },
}
