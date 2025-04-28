-- core/keymaps.lua
local map = vim.keymap.set
local cmd = vim.cmd

-- NOW WE CAN:
-- - :edit a folder to open a file browser
-- - <CR>/v/t to open in an h-split/v-split/tab
-- - check |netrw-browse-maps| for more mappings
--
-- Use for example `:edit <filename>` to open files in a tree

-- SNIPPETS:
--
-- Read an empty HTML template and move cursor to title
map("n", ",html", ":-1read $HOME/.vim/.skeleton.html<CR>3jwf>a", { noremap = true, silent = true })
-- <CR> is carriage return, without it we would simply type the command into
-- command mode
-- 3jwf>a is how you end up with the cursor in a specific spot, using Vim
-- commands
-- nnoremap is so there is no recursive invocation of ,html
-- -1 in the read command is so it doesn't add a boilerplate line when it adds
-- the snippet

-- NOW WE CAN:
-- - Take over the world!
--   (with much fewer keystrokes)

-- Comment
map("n", "mm", "gcc", { desc = "Toggle comment", remap = true })
map("v", "mm", "gc", { desc = "Toggle comment", remap = true })

-- Terminal
map("n", "tt", function()
    local height = math.floor(vim.o.lines / 2)
    cmd("belowright split | resize " .. height .. " | terminal")
end, { noremap = true, silent = true })

-- Reload
function _G.reload_config()
    for name, _ in pairs(package.loaded) do
        if name:match "^me" then package.loaded[name] = nil end
    end

    dofile(vim.env.MYVIMRC)
    vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

map("n", "rr", _G.reload_config, { desc = "Reload configuration without restart nvim" })
