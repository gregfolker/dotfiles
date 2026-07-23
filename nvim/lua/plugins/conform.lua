return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			yaml = { "yamlfmt" },
			markdown = { "prettier" },
			dts = { "dts_linter" },
			["_"] = { "trim_whitespace" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 2500,
		},
		formatters = {
			dts_linter = {
				stdin = false,
				command = "dts-linter",
				args = { "--formatFixAll", "--file", "$FILENAME" },
			},
		},
	},
}
