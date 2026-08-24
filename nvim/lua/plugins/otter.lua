return {
	"jmbuhr/otter.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		-- Enable LSP features and code completion for code
		-- embedded into mise files.
		-- https://mise.jdx.dev/mise-cookbook/neovim.html#enable-lsp-for-embedded-lang-in-run-commands
		vim.api.nvim_create_autocmd({ "FileType" }, {
			pattern = { "toml" },
			group = vim.api.nvim_create_augroup("EmbedToml", {}),
			callback = function()
				require("otter").activate()
			end,
		})
	end,
}
