return {
	"vague2k/huez.nvim",
	branch = "stable",
	event = "UIEnter",
	fallback = "catppuccin",
	suppress_messages = false,
	dependencies = {
		{ "scottmckendry/cyberdream.nvim", lazy = true, enabled = true },
		{ "samharju/synthweave.nvim", lazy = true, enabled = true },
		{ "folke/tokyonight.nvim", lazy = true, enabled = true },
		{ "rafamadriz/neon", lazy = true, enabled = true },
		{ "rose-pine/neovim", lazy = true, enabled = true },
		{ "metalelf0/jellybeans-nvim", lazy = true, enabled = true },
		{ "hyperb1iss/silkcircuit", lazy = true, enabled = true },
		{ "embark-theme/vim", lazy = true, enabled = true },
	},
	config = function()
		require("huez").setup()
	end,
}
