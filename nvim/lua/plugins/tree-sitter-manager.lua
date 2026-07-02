return {
	"romus204/tree-sitter-manager.nvim",
	dependencies = {}, -- tree-sitter CLI must be installed system-wide
	config = function()
		require("tree-sitter-manager").setup({
			auto_install = true, -- auto-install when a new filetype is encountered

			-- For some reason, the diff in commit messages is not colored when using
			-- the treesitter parser. It works with it disabled though,
			-- so just use the default coloring when opening commit messages. I suspect
			-- this is actually an issue with the theme not setting the gitcommit colors
			-- correctly but ¯\_(ツ)_/¯
			nohighlight = { "gitcommit", "csv" },
		})
	end,
}
