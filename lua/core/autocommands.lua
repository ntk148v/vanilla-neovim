-- core/autocommands.lua
-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup
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
    api.nvim_clear_autocmds({ group = group, buffer = bufnr })

    api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        group = group,
        desc = "LSP format on save",
        callback = function()
            -- note: do not enable async formatting
            lsp.buf.format({ async = false, timeout_ms = 10000 })
        end,
    })
end

api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local id = vim.tbl_get(event, "data", "client_id")
        local client = id and lsp.get_client_by_id(id)
        if client == nil then
            return
        end

        -- make sure there is at least one client with formatting capabilities
        if client.supports_method("textDocument/formatting") then
            buffer_autoformat(event.buf)
        end
    end,
})

local statusline_group = api.nvim_create_augroup("Statusline", { clear = true })
api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    pattern = "*",
    group = statusline_group,
    command = "setlocal statusline=%!v:lua.statusline_active()",
})

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = "1000",
        })
    end,
})

-- Remove whitespace on save
api.nvim_create_autocmd("BufWritePre", {
    pattern = "",
    command = ":%s/\\s\\+$//e",
})

-- Auto format on save using the attached (optionally filtered) language servere clients
-- https://neovim.io/doc/user/lsp.html#vim.lsp.buf.format()
api.nvim_create_autocmd("BufWritePre", {
    pattern = "",
    command = ":silent lua vim.lsp.buf.format()",
})

-- Don"t auto commenting new lines
api.nvim_create_autocmd("BufEnter", {
    pattern = "",
    command = "set fo-=c fo-=r fo-=o",
})

api.nvim_create_autocmd("Filetype", {
    pattern = { "xml", "html", "xhtml", "css", "scss", "javascript", "typescript", "yaml", "lua" },
    command = "setlocal shiftwidth=2 tabstop=2",
})

-- Set colorcolumn
api.nvim_create_autocmd("Filetype", {
    pattern = { "python", "rst", "c", "cpp" },
    command = "set colorcolumn=80",
})

api.nvim_create_autocmd("Filetype", {
    pattern = { "gitcommit", "markdown", "text" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})
