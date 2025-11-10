vim.lsp.enable("pyright")
vim.lsp.config("pyright", {
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
})
