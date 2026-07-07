return {
	"NeogitOrg/neogit",
	lazy = true,
	dependencies = {
		"esmuellert/codediff.nvim",
		"m00qek/baleia.nvim", -- For a custom log pager
		"nvim-telescope/telescope.nvim",
	},
	cmd = "Neogit",
	keys = {
		{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
	},
	opts = function()
		require("neogit").setup({
			disable_insert_on_commit = true,
			graph_style = "unicode",
			commit_editor = {
				show_staged_diff = true,
				staged_diff_split_kind = "vsplit",
			},
		})
	end,
}
