return {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    version = false,
    config = function()
        require("mini.pairs").setup()
        require("mini.ai").setup()
        require("mini.surround").setup()
        require("mini.icons").setup()
        require("mini.statusline").setup()

        MiniIcons.mock_nvim_web_devicons()
    end,
}
