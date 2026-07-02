return {
	"nvimdev/dashboard-nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "MaximilianLloyd/ascii.nvim" },
	},
	event = "VimEnter",
	config = function()
		local splash = require("ascii").art.misc.skulls.angryskull
		require("dashboard").setup({
			theme = "doom",
			config = {
				header = splash,
				center = {
					{
						icon = "  ",
						desc = "New File",
						action = "ene | startinsert",
						key = "n",
					},
					{
						icon = "  ",
						desc = "Open File",
						action = "Telescope find_files",
						key = "o",
					},
					{
						icon = "  ",
						desc = "Recent Files",
						action = "Telescope oldfiles",
						key = "r",
					},
					{
						icon = "  ",
						desc = "Search",
						action = "Telescope live_grep",
						key = "s",
					},
					{
						icon = "  ",
						desc = "Projects",
						action = "Telescope projects",
						key = "p",
					},
					{
						icon = "󰒲  ",
						desc = "Lazy",
						action = "Lazy",
						key = "l",
					},
					{
						icon = "  ",
						desc = "Update",
						action = "Lazy update",
						key = "u",
					},
					{
						icon = "󰩈  ",
						desc = "Quit",
						action = ":qa",
						key = "q",
					},
				},
				footer = function()
					local datetime = os.date("  %A, %B %d   %I:%M %p")
					local version = " "
						.. vim.version().major
						.. "."
						.. vim.version().minor
						.. "."
						.. vim.version().patch

					return {
						datetime,
						"",
						version,
					}
				end,
				vertical_center = true,
			},
		})
	end,
}
