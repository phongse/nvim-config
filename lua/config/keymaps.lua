vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = require("config.utils").keymap

keymap("n", "<Esc>", ":nohl<CR>", "Clear search highlights")
keymap("n", "<A-v>", "<C-v>", "Visual Block Mode")

-- UI toggles
keymap("n", "<leader>uw", function()
    vim.wo.wrap = not vim.wo.wrap
end, "Toggle line wrap")

keymap("n", "<leader>ul", function()
    vim.wo.number = not vim.wo.number
end, "Toggle line number")

keymap("n", "<leader>uL", function()
    vim.wo.relativenumber = not vim.wo.relativenumber
end, "Toggle relative number")

keymap("n", "<leader>uv", function()
    vim.diagnostic.config({
        virtual_lines = not vim.diagnostic.config().virtual_lines,
    })
end, "Toggle virtual lines")

-- Buffer
keymap("n", "<leader>bd", ":bd<cr>", "Buffer delete")

-- Move lines
keymap("n", "<A-j>", ":m .+1<cr>==", "Move Line Down")
keymap("n", "<A-k>", ":m .-2<cr>==", "Move Line Up")
keymap("i", "<A-j>", "<esc>:m .+1<cr>==gi", "Move Line Down")
keymap("i", "<A-k>", "<esc>:m .-2<cr>==gi", "Move Line Up")
keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", "Move Line Down")
keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", "Move Line Up")
keymap("v", "<", "<gv", "Better Visual indent")
keymap("v", ">", ">gv", "Better Visual indent")

-- Move window without <C-w>
keymap("n", "<C-j>", "<C-w>j", "Move window [d]own")
keymap("n", "<C-k>", "<C-w>k", "Move window [u]p")
keymap("n", "<C-h>", "<C-w>h", "Move window [l]eft")
keymap("n", "<C-l>", "<C-w>l", "Move window [r]ight")

-- Resize window
keymap("n", "<C-left>", "<C-w><", "Decrease window width")
keymap("n", "<C-right>", "<C-w>>", "Increase window width")
keymap("n", "<C-up>", "<C-w>+", "Increase window height")
keymap("n", "<C-down>", "<C-w>-", "Decrease window height")
