return {
	"michaelb/sniprun",
	branch = "master",

	-- do 'sh install.sh 1' if you want to force compile locally
	-- (instead of fetching a binary from the github release). Requires Rust >= 1.65
	build = "sh install.sh",

	config = function()
		require("sniprun").setup({
			display = {
				"TerminalWithCodeOk",
				"ClassicErr",
			},
			show_no_output = {
				"Classic",
			},
		})
	end,
}
