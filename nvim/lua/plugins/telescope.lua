return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- optional but recommended
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				-- Prevent specific hidden folders from polluting results
				file_ignore_patterns = {
					"%.git/",
				},
			},
			pickers = {
				find_files = {
					find_command = { "fd", "--type", "f", "-I", "--hidden", "--exclude", ".git" },
				},
				live_grep = {
					-- Ensure live_grep searches inside hidden files/folders as well
					additional_args = function()
						return { "--hidden" }
					end,
				},
				oldfiles = {
					cwd_only = true,
				},
			},
		})
	end,
}
