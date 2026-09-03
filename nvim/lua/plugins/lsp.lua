return {
	{
		-- Package manager for LSPs/Linters/Formatters
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		-- Pre-built configurations for LSPs
		"neovim/nvim-lspconfig",
	},
	{
		-- Automatic LSP enablement for tools visible to mason
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {},
	},
	{
		-- Automatic installation for missing tools. Only used
		-- for tools not available in mise. In general, system
		-- installation with mise is preferred so the tools are
		-- also available outside of neovim.
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"mason-org/mason.nvim",
		},
		opts = {
			ensure_installed = {
				-- Language Servers
				"bash-language-server",
				"clangd",
			},
		},
	},
	{
		"zeioth/garbage-day.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lspsaga").setup({})
		end,
	},
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		config = function()
			vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

			require("outline").setup({
				-- Your setup opts here (leave empty to use defaults)
			})
		end,
	},
}
