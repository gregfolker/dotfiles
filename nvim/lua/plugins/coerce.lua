return {
	"gregorias/coerce.nvim",
	tag = "v5.0.0",
	config = function()
		-- Example configuration. For more options, see the configuration section.
		require("coerce").setup()
		vim.keymap.set("n", "cr", "<Plug>(coerce-normal)", { desc = "Coerce word" })
		vim.keymap.set("n", "gcr", "<Plug>(coerce-motion)", { desc = "Coerce motion" })
		vim.keymap.set("x", "gcr", "<Plug>(coerce-visual)", { desc = "Coerce visual" })
	end,
}
