local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	'clangd',
	'jdtls',
	'rust_analyzer',
})

lsp.set_preferences({
	sign_icons = { }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<S-Tab>'] = cmp.mapping.select_prev_item(cmp.select),
	['<Tab>'] = cmp.mapping.select_next_item(cmp.select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	["<C-Space"] = cmp.mapping.complete(),
})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.lsp.buf.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.lsp.buf.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.lsp.buf.goto_prev() end, opts)
	vim.keymap.set("n", "rn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require('lspconfig').clangd.setup{
  on_attach = lsp.on_attach,
  cmd = {
    "clangd",
    "--query-driver=/bin/clang,/bin/clang++,usr/bin/gcc,/usr/bin/g++",
    "--background-index",
    "--pch-storage=memory",
    "--clang-tidy",
    "--suggest-missing-includes",
    "--all-scopes-completion",
    "--pretty",
    "--header-insertion=never",
    "-j=4",
    "--inlay-hints",
    "--header-insertion-decorators",
  },
  filetypes = {"c", "cpp", "objc", "objcpp"},
  -- root_dir = utils.root_pattern("compile_commands.json", "compile_flags.txt", ".git")
  init_option = { fallbackFlags = {  "-std=c++20"  } }
}

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
    sign = true,
    update_in_insert = false,
    underline = true,
    severity_sort = false,
    float = true,
})
