-- core/keymaps.lua
local map = vim.keymap.set

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
