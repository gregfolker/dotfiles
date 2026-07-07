return {
	"fedepujol/move.nvim",
	keys = {
		-- Visual Mode
		{ "<A-j>", ":MoveBlock(1)<CR>", mode = { "v" }, desc = "Move Block Up" },
		{ "<A-k>", ":MoveBlock(-1)<CR>", mode = { "v" }, desc = "Move Block Down" },
		{ "<A-h>", ":MoveHBlock(-1)<CR>", mode = { "v" }, desc = "Move Block Left" },
		{ "<A-l>", ":MoveHBlock(1)<CR>", mode = { "v" }, desc = "Move Block Right" },
	},
	opts = {
		-- Config here
	},
}
