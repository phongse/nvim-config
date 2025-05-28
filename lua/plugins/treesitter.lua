return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",
        build = {
            -- Requires manual install of new parsers as this is only triggered
            -- on nvim-treesitter update
            ":TSInstall dockerfile",
            ":TSInstall json",
            ":TSInstall lua",
            ":TSInstall markdown",
            ":TSInstall python",
            ":TSInstall regex",
            ":TSInstall toml",
            ":TSInstall yaml",
            ":TSUpdate",
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPost",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            on_attach = function()
                vim.keymap.set("n", "[p", function()
                    require("treesitter-context").go_to_context(vim.v.count1)
                end, { desc = "Goto treesitter context", silent = true })
            end,
        },
    },
}
