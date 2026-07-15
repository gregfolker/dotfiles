return {
	"krady21/compiler-explorer.nvim",
	dependencies = {
		"rcarriga/nvim-notify",
		"stevearc/dressing.nvim",
	},
	opts = {},
	config = function()
		require("compiler-explorer").setup({
			line_match = {
				highlight = true,
				jump = true,
			},
			languages = {
				c = {
					-- https://best.openssf.org/Compiler-Hardening-Guides/Compiler-Options-Hardening-Guide-for-C-and-C++.html
					compiler_flags = "-O2 -Wall -Wformat=2 -Wconversion -Wimplicit-fallthrough -Werror=format-security",
				},
			},
		})
	end,
}
