vim.lsp.config("dts-lsp", {
	cmd = { "dts-lsp" },
	filetypes = { "dts" },
})
vim.lsp.enable({ "dts-lsp" })
