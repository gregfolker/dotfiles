return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			c = { "clang-format" },
			cmake = { "cmake_format" },
			dts = { "dts_linter" },
			dockerfile = { "dockerfmt" },
			pkl = { "pkl" },
			lua = { "stylua" },
			python = { "ruff_format" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			yaml = { "yamlfmt" },
			markdown = { "prettier" },
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
