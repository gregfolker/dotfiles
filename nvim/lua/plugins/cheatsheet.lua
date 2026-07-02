return {
	"doctorfree/cheatsheet.nvim",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
		{ "nvim-lua/popup.nvim" },
		{ "nvim-lua/plenary.nvim" },
	},
	config = function()
		local ctactions = require("cheatsheet.telescope.actions")
		require("cheatsheet").setup({
			bundled_cheetsheets = true,
			include_only_installed_plugins = true,

			-- Key mappings bound to the telescope window
			telescope_mappings = {
				["<CR>"] = ctactions.select_or_execute,
				["<A-CR>"] = ctactions.select_or_fill_commandline,
				["<C-Y>"] = ctactions.copy_cheat_value,
				["<C-E>"] = ctactions.edit_user_cheatsheet,
			},
		})
	end,
}
