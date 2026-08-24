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

			ensure_installed = {
				"c",
				"python",
				"bash",
				"lua",
				"yaml",
			},

			-- Add the `is-mise?` predicate for syntax highlighting in mise files
			require("vim.treesitter.query").add_predicate("is-mise?", function(_, _, bufnr, _)
				local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
				local filename = vim.fn.fnamemodify(filepath, ":t")
				return string.match(filename, ".*mise.*%.toml$") ~= nil
			end, { force = true, all = false }),
		})
	end,
}
