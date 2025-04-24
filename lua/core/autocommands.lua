-- utils/autocommands.lua
local api = vim.api
local g = vim.g
local lsp = vim.lsp

-- Autocommands for netrw
-- Safely configure netrw_list_hide once netrw is loaded
api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        local hide = vim.fn["netrw_gitignore#Hide"]()
        g.netrw_list_hide = hide .. ",\\(^\\|\\s\\s\\)\\zs\\.\\S\\+"
    end,
})

-- Enable Format on save
local buffer_autoformat = function(bufnr)
    local group = "lsp_autoformat"
    api.nvim_create_augroup(group, { clear = false })
    api.nvim_clear_autocmds { group = group, buffer = bufnr }

    api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        group = group,
        desc = "LSP format on save",
        callback = function()
            -- note: do not enable async formatting
            lsp.buf.format { async = false, timeout_ms = 10000 }
        end,
    })
end

api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local id = vim.tbl_get(event, "data", "client_id")
        local client = id and lsp.get_client_by_id(id)
        if client == nil then return end

        -- make sure there is at least one client with formatting capabilities
        if client.supports_method "textDocument/formatting" then buffer_autoformat(event.buf) end
    end,
})

local statusline_group = api.nvim_create_augroup("Statusline", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    pattern = "*",
    group = statusline_group,
    command = "setlocal statusline=%!v:lua.statusline_active()",
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    pattern = "*",
    group = statusline_group,
    command = "setlocal statusline=%!v:lua.statusline_inactive()",
})
