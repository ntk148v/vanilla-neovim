-- utils/autocommands.lua
local api = vim.api
local g = vim.g

-- Autocommands for netrw
-- Safely configure netrw_list_hide once netrw is loaded
api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    local hide = vim.fn["netrw_gitignore#Hide"]()
    g.netrw_list_hide = hide .. ',\\(^\\|\\s\\s\\)\\zs\\.\\S\\+'
  end,
})
