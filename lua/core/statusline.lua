-- Get from: https://github.com/nuxshed/dotfiles/blob/main/config/nvim/lua/statusline.lua
-- with a few modifications
local fn = vim.fn
local api = vim.api

local modes = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["v"] = "VISUAL",
    ["V"] = "VISUAL LINE",
    [""] = "VISUAL BLOCK",
    ["s"] = "SELECT",
    ["S"] = "SELECT LINE",
    [""] = "SELECT BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rv"] = "VISUAL REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
}

local function mode()
    local current_mode = api.nvim_get_mode().mode
    return string.format(" %s ", modes[current_mode]):upper()
end

local function update_mode_colors()
    local current_mode = api.nvim_get_mode().mode
    local mode_color = "%#StatusLineAccent#"
    if current_mode == "n" then
        mode_color = "%#StatuslineAccent#"
    elseif current_mode == "i" or current_mode == "ic" then
        mode_color = "%#StatuslineInsertAccent#"
    elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
        mode_color = "%#StatuslineVisualAccent#"
    elseif current_mode == "R" then
        mode_color = "%#StatuslineReplaceAccent#"
    elseif current_mode == "c" then
        mode_color = "%#StatuslineCmdLineAccent#"
    elseif current_mode == "t" then
        mode_color = "%#StatuslineTerminalAccent#"
    end
    return mode_color
end

local function current_filetype()
    return string.format(" %s ", vim.bo.filetype):upper()
end

local function lineinfo()
    if vim.bo.filetype == "alpha" then
        return ""
    end
    return " %P %l:%c "
end

local function lsp()
    local count = {}
    local levels = {
        errors = "Error",
        warnings = "Warn",
        info = "Info",
        hints = "Hint",
    }

    for k, level in pairs(levels) do
        count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    local errors = ""
    local warnings = ""
    local hints = ""
    local info = ""

    if count["errors"] ~= 0 then
        errors = " %#LspDiagnosticsSignError# " .. count["errors"]
    end
    if count["warnings"] ~= 0 then
        warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
    end
    if count["hints"] ~= 0 then
        hints = " %#LspDiagnosticsSignHint# " .. count["hints"]
    end
    if count["info"] ~= 0 then
        info = " %#LspDiagnosticsSignInformation# " .. count["info"]
    end

    -- Only include LSP clients that support the current buffer's filetype
    local filetype = vim.bo.filetype
    local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
    local client_names = {}

    for _, client in ipairs(buf_clients) do
        if client.config and client.config.filetypes and vim.tbl_contains(client.config.filetypes, filetype) then
            table.insert(client_names, client.name)
        end
    end

    local lsp_name = ""
    if next(client_names) ~= nil then
        lsp_name = " %#StatusLineLsp# " .. table.concat(client_names, ", ")
    end

    return errors .. warnings .. hints .. info .. lsp_name .. " %#Normal#"
end

function _G.statusline_active()
    return table.concat({
        "%#Statusline#",
        update_mode_colors(),
        mode(),
        "%#Normal# ",
        "%#Normal#",
        "%=%#StatusLineExtra#",
        lsp(),
        current_filetype(),
        lineinfo(),
    })
end

function _G.statusline_inactive()
    return " %F"
end
