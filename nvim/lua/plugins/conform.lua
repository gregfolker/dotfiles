return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			yaml = { "yamlfmt" },
			markdown = { "prettier" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},
	},
}
