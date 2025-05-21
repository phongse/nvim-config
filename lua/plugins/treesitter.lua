return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "dockerfile",
                    "json",
                    "lua",
                    "markdown",
                    "python",
                    "regex",
                    "toml",
                    "yaml",
                },
                sync_install = false,
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
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
