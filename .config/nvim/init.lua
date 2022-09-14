require('plugins')

-- comma as leader
vim.g.mapleader = ","

-- load legacy options
vim.cmd([[
	so ~/.config/nvim/legacy.vim
]])

vim.cmd [[packadd packer.nvim]]

require('mylsp')
require('nvimcmp')

-- lsp_signature.nvim
lsp_signature_cfg = {
    hint_prefix = "",
    floating_window = false
}
require "lsp_signature".setup(lsp_signature_cfg)

-- lualine
require('lualine').setup()

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = {"c", "cpp", "cmake", "lua", "rust"},
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
}

require('nvim-autopairs').setup {}
