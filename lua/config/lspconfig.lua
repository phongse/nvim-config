local utils = require("config.utils")
local keymap = utils.keymap

local opts = {
    diagnostic = {
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        virtual_text = {
            prefix = "●",
        },
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = " ",
                [vim.diagnostic.severity.INFO] = " ",
                [vim.diagnostic.severity.HINT] = " ",
            },
        },
    },
    inlay_hints = {
        enabled = true,
    },
    document_highlight = {
        enabled = true,
    },
}
vim.diagnostic.config(opts.diagnostic)

local lsp_attach_group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true })
local detach_augroup = vim.api.nvim_create_augroup("UserLspDetach", { clear = true })
local highlight_augroup =
    vim.api.nvim_create_augroup("UserLspHighlight", { clear = false })

vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_attach_group,
    callback = function(event)
        local bufnr = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if not client then
            return
        end

        keymap({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        keymap("n", "<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
        keymap("n", "<leader>cf", utils.code_action("source.fixAll"), "Fix all")
        keymap(
            "n",
            "<leader>co",
            utils.code_action("source.organizeImports"),
            "Organize imports"
        )
        keymap("n", "<leader>ud", function()
            vim.diagnostic.enable(not vim.diagnostic.is_enabled(), { bufnr = 0 })
        end, "Toggle diagnostics")

        if
            client:supports_method(
                vim.lsp.protocol.Methods.textDocument_documentHighlight,
                bufnr
            ) and opts.document_highlight.enabled
        then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = bufnr,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = bufnr,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = detach_augroup,
                callback = function()
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({
                        group = highlight_augroup,
                        buffer = bufnr,
                    })
                end,
            })
        end

        if
            client:supports_method(
                vim.lsp.protocol.Methods.textDocument_inlayHint,
                bufnr
            )
        then
            vim.lsp.inlay_hint.enable(opts.inlay_hints.enabled)
            keymap("n", "<leader>uh", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, "Toggle inlay hints")
        end
    end,
})
