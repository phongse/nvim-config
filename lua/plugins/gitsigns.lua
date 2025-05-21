return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
        on_attach = function()
            local gitsigns = require("gitsigns")
            local keymap = require("config.utils").keymap

            keymap("n", "]c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end, "Next hunk")

            keymap("n", "[c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gitsigns.nav_hunk("prev")
                end
            end, "Previous hunk")

            keymap({ "n", "v" }, "<leader>ghs", function()
                gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Stage hunk")

            keymap({ "n", "v" }, "<leader>ghr", function()
                gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Reset hunk")

            keymap("n", "<leader>ghS", gitsigns.stage_buffer, "Stage buffer")
            keymap("n", "<leader>ghR", gitsigns.reset_buffer, "Reset buffer")
            keymap("n", "<leader>ghp", gitsigns.preview_hunk, "Preview hunk")
            keymap(
                "n",
                "<leader>ghi",
                gitsigns.preview_hunk_inline,
                "Preview hunk inline"
            )

            keymap("n", "<leader>ghb", function()
                gitsigns.blame_line({ full = true })
            end, "Blame line")
            keymap("n", "<leader>ghB", gitsigns.blame, "Blame buffer")

            keymap("n", "<leader>ghd", gitsigns.diffthis, "Diff this")

            keymap("n", "<leader>ghD", function()
                gitsigns.diffthis("~")
            end, "Diff this buffer")

            keymap(
                "n",
                "<leader>gtb",
                gitsigns.toggle_current_line_blame,
                "Toggle blame line"
            )
            keymap(
                "n",
                "<leader>gtd",
                gitsigns.preview_hunk_inline,
                "Preview hunk inline"
            )
            keymap("n", "<leader>gtw", gitsigns.toggle_word_diff, "Toggle word diff")

            keymap({ "o", "x" }, "ghih", gitsigns.select_hunk)
        end,
    },
}
