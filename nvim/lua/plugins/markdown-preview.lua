return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install", -- requires yarn and npm installed
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }

		-- do not close the preview when switching buffers
		vim.g.mkdp_auto_close = false
	end,
	ft = { "markdown" },
}
