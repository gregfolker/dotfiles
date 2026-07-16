return {
	"Pocco81/true-zen.nvim",
	config = function()
		require("true-zen").setup({
			modes = {
				narrow = {
					fold_style = "invisible", -- hide fold lines
				},
			},
		})
	end,
}
