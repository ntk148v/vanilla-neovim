-- core/options.lua

function _G.Tabline()
    local s = ""
    for i = 1, vim.fn.bufnr("$") do
        if vim.fn.bufexists(i) == 1 and vim.fn.buflisted(i) == 1 then
            local bufname = vim.fn.fnamemodify(vim.fn.bufname(i), ":t")
            if bufname == "" then
                bufname = "[No Name]"
            end
            if i == vim.fn.bufnr() then
                s = s .. "%#TabLineSel#"
            else
                s = s .. "%#TabLine#"
            end
            s = s .. " " .. i .. ": " .. bufname .. " "
        end
    end
    s = s .. "%#TabLineFill#"
    return s
end

local cmd = vim.cmd
-- Set options (global/buffer/windows-scoped)
local o = vim.opt
-- Global variables
local g = vim.g
local indent = 4

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
g.mapleader = " "
g.maplocalleader = " "

-- BASIC SETUP:
-- don't bother with pretending that it wants to be compatible with Vi
o.compatible = false

cmd([[
	filetype plugin indent on
]])

-- FINDING FILES:
-- Search down into subfolders:
-- Provides tab-completion for all file-related tasks
o.path:append("**")

-- Sync clipboard between Neovim and the system.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

-- Display all matching files when we tab complete
o.wildmenu = true
o.number = true

-- Enable break indent
o.breakindent = true

o.backspace = { "eol", "start", "indent" } -- allow backspacing over everything in insert mode
o.fileencoding = "utf-8" -- the encoding written to a file
o.encoding = "utf-8" -- the encoding
o.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
-- enable syntax and plugins (for netrw)
o.syntax = "enable"

-- indention
o.autoindent = true -- auto indentation
o.expandtab = true -- convert tabs to spaces
o.shiftwidth = indent -- the number of spaces inserted for each indentation
o.smartindent = true -- make indenting smarter
o.softtabstop = indent -- when hitting <BS>, pretend like a tab is removed, even if spaces
o.tabstop = indent -- insert 2 spaces for a tab
o.shiftround = true -- use multiple of shiftwidth when indenting with "<" and ">"

-- search
o.hlsearch = true -- highlight all matches on previous search pattern
o.ignorecase = true -- ignore case in search patterns unless \C or one or more capital letters in the search term
o.smartcase = true -- smart case
o.wildignore = o.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
o.wildmenu = true -- make tab completion for files/buffers act like bash
o.inccommand = "split" -- review substitutions live, as you type

-- ui
o.cursorline = true -- highlight the current line
o.laststatus = 2 -- only the last window will always have a status line
o.lazyredraw = true -- don"t update the display while executing macros
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
o.list = true
-- You can also add "space" or "eol", but I feel it"s quite annoying
o.listchars = {
    tab = "┊ ",
    trail = "·",
    extends = "»",
    precedes = "«",
    nbsp = "×",
}

-- Hide cmd line
o.cmdheight = 0 -- more space in the neovim command line for displaying messages

o.mouse = "a" -- allow the mouse to be used in neovim
o.number = true -- set numbered lines
-- opt.relativenumber = true -- set relative numbered lines, to help with jumping.
o.scrolloff = 18 -- minimal number of screen lines to keep above and below the cursor
o.sidescrolloff = 3 -- minimal number of screen columns to keep to the left and right (horizontal) of the cursor if wrap is `false`
o.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
o.splitbelow = true -- open new split below
o.splitright = true -- open new split to the right
o.wrap = true -- display a wrapped line

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
o.confirm = true

-- backups
o.backup = false -- create a backup file
o.swapfile = false -- creates a swapfile
o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- tabline
o.showtabline = 2 -- always show tabs
o.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"
o.tabline = "%!v:lua.Tabline()"

-- autocomplete
o.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
o.shortmess = o.shortmess + {
    c = true,
} -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"

-- By the way, -- INSERT -- is unnecessary anymore because the mode information is displayed in the statusline.
o.showmode = false

-- perfomance
-- remember N lines in history
o.history = 100 -- keep 100 lines of history
o.redrawtime = 1500
o.timeoutlen = 250 -- time to wait for a mapped sequence to complete (in milliseconds)
o.ttimeoutlen = 10
o.updatetime = 100 -- signify default updatetime 4000ms is not good for async update

-- theme
-- disable 24-bit RGB colors to use terminal colors for neovim
-- if you want to set other colorscheme, feel free to enable it
vim.opt.termguicolors = false

-- persistent undo
-- Don"t forget to create folder $HOME/.local/share/nvim/undo
local undodir = vim.fn.stdpath("data") .. "/undo"
o.undofile = true -- enable persistent undo
o.undodir = undodir
o.undolevels = 1000
o.undoreload = 10000

-- fold
o.foldmethod = "marker"
o.foldlevel = 99

-- Disable builtin plugins
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "tutor",
    "rplugin",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

-- NOW WE CAN:
-- - Use ^] to jump to tag under cursor.
-- - Use g^] for ambiguous tags
-- - Use ^t to jump back up the tag stack

-- THINGS TO CONSIDER:
-- - This doesn't help if you want a visual list of tags

-- Use `:echo expand("%")` to get the current file name

-- AUTOCOMPLETE:
--
-- The good stuff is documented in |ins-completion|
-- - ^x^n for JUST this file
-- - ^x^f for filenames (works with our path trick!)
-- - ^x^] for tags only
-- - ^n for anything specified by the 'complete' option
--
-- NOW WE CAN:
-- - Use ^n and ^p to go back and forth in the suggestion list

-- FILE BROWSING:
--
-- Tweaks for browsing
g.netrw_banner = 0 -- disable annoying banner
g.netrw_browse_split = 4 -- open in prior window
g.netrw_altv = 1 -- open splits to the right
g.netrw_liststyle = 3 -- tree view

-- Enable virtual_lines feature if the current nvim version is 0.11+
if vim.fn.has("nvim-0.11") > 0 then
    vim.diagnostic.config({
        -- Use the default configuration
        virtual_lines = true,

        -- Alternatively, customize specific options
        -- virtual_lines = {
        --  -- Only show virtual line diagnostics for the current cursor line
        --  current_line = true,
        -- },
    })
end
