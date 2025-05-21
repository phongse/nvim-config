return {
    "saghen/blink.cmp",
    event = { "InsertEnter" },
    dependencies = {
        "rafamadriz/friendly-snippets",
        "folke/lazydev.nvim",
    },
    version = "1.*",

    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {
            list = {
                selection = { auto_insert = false },
            },
            ghost_text = { enabled = true },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },
            menu = {
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind_icon", "kind" },
                    },
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                local kind_icon, _, _ =
                                    require("mini.icons").get("lsp", ctx.kind)
                                return kind_icon
                            end,
                            highlight = function(ctx)
                                local _, hl, _ =
                                    require("mini.icons").get("lsp", ctx.kind)
                                return hl
                            end,
                        },
                        kind = {
                            highlight = function(ctx)
                                local _, hl, _ =
                                    require("mini.icons").get("lsp", ctx.kind)
                                return hl
                            end,
                        },
                    },
                },
            },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        keymap = { preset = "default" },
        signature = { enabled = true },
        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },
    },
    opts_extend = { "sources.default" },
}
