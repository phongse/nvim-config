return {
    {
        "neovim/nvim-lspconfig",
        -- No need to load the plugin, since we just want its configs
        init = function()
            vim.opt.runtimepath:prepend(
                require("lazy.core.config").options.root .. "/nvim-lspconfig"
            )
            vim.lsp.enable({
                "basedpyright",
                "biome",
                "docker_compose_language_service",
                "dockerls",
                "lua_ls",
                "ruff",
            })
        end,
        cmd = { "LspInfo", "LspStart", "LspStop", "LspRestart" },
    },
    {
        "mason-org/mason.nvim",
        cmd = { "Mason" },
        init = function()
            -- No need to load the plugin, since we just want the binaries
            vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. ":" .. vim.env.PATH
        end,
        opts = {
            -- Requires to launch `:Mason` since we only add bin path at init
            ensure_installed = {
                -- lsp
                "basedpyright",
                "biome",
                "docker-compose-language-service",
                "dockerfile-language-server",
                "lua-language-server",
                "ruff",

                -- formatters
                "stylua",

                -- linters
                "hadolint",
                "selene",
            },
        },
        config = function(_, opts)
            require("mason").setup()
            local mr = require("mason-registry")

            mr.refresh(function()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end)
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        cmd = "LazyDev",
        opts = {
            library = {
                { path = "snacks.nvim", words = { "Snacks" } },
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
