vim.lsp.enable("gopls")
vim.lsp.config("gopls", {
    cmd = { "gopls" },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                unreachable = true,
            },
            staticcheck = true,
        },
    },
})
