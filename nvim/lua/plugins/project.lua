return {
	"ahmedkhalf/project.nvim",
	config = function()
		require("project_nvim").setup({
			silent_chdir = false,
			scope_chdir = "tab",
			exclude_dirs = { "/tmp/*", "/opt/*" },
			show_hidden = true,
		})
	end,
}
