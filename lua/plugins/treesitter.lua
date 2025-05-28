return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",
        build = ":TSUpdate",
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local filetype = args.match
                    local lang = vim.treesitter.language.get_lang(filetype)
                    if
                        vim.tbl_contains(
                            require("nvim-treesitter.config").get_available(),
                            lang
                        )
                    then
                        require("nvim-treesitter").install(lang):await(function()
                            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                            vim.bo.indentexpr =
                                "v:lua.require'nvim-treesitter'.indentexpr()"
                            vim.treesitter.start()
                        end)
                    end
                end,
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
