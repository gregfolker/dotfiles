return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	config = function()
		require("markview").setup({
			preview = {
				icon_provider = "devicons",
				-- Disable automatic previews
				enable = false,
			},
		})
		vim.api.nvim_set_keymap("n", "<leader>m", "<CMD>Markview<CR>", { desc = "Toggles `markdown` preview globally" })
	end,
}
