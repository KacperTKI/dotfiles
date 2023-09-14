require "plugins"

-- space as leader
vim.g.mapleader = " "

-- load legacy options
vim.cmd([[
	so ~/.config/nvim/legacy.vim
]])

vim.cmd [[packadd packer.nvim]]

require('set')
require('remap')

require('mylsp')
require('diagnostics')
require('nvimcmp')

-- lualine
require('lualine').setup()

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
	ensure_installed = {"c", "java", "cpp", "cmake", "lua", "rust", "vim"},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	}
}

require('nvim-autopairs').setup {}
