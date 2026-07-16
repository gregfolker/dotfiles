vim.filetype.add({
	filename = {
		[".env"] = "sh",
	},
	pattern = {
		["%.functions"] = { "sh", { priority = 1 } },
		["%.aliases"] = { "sh", { priority = 1 } },
		["Brewfile.*"] = "ruby",
	},
})
