return {
	"allaman/emoji.nvim",
	version = "*",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	opts = {},
	config = function(_, opts)
		require("emoji").setup(opts)
		local ts = require("telescope").load_extension("emoji")
		vim.keymap.set("n", "<leader>se", ts.emoji, { desc = "[S]earch [E]moji" })
		vim.keymap.set("n", "<leader>sk", ts.kaomoji, { desc = "[S]earch [K]aomoji" })
	end,
}
