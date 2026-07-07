return {
	"gelguy/wilder.nvim",
	opts = function()
		local wilder = require("wilder")
		wilder.setup({ modes = { ":", "/", "?" } })
	end,
}
