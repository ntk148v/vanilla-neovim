if vim.fn.has('nvim-0.11') == 0 then error('Need Neovim 0.11+ in order to use this config') end

-- init.lua
require('core.options')
require('core.keymaps')
require('core.autocommands')

-- Theme setup
require('theme.colorscheme')

-- LSP configuration
require('lsp.init')
