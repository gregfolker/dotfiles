return {
	"tadaa/vimade",
	config = function()
		require("vimade").setup({
			recipe = { "default", { animate = true } },
			fadelevel = 0.7,
			exclude_filetypes = { "dashboard", "help", "calendar" },
			blocklist = {
				assembly = {
					buf_opts = {
						-- Assembly is almost always open in a split to view alongside source code,
						-- so never dim those windows
						ft = "asm",
					},
				},
			},
		})
	end,
}
