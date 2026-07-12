return {
	"hedyhli/outline.nvim",
	lazy = true,
	cmd = { "Outline", "OutlineOpen" },
	config = function()
		vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

		require("outline").setup({
			-- Your setup opts here (leave empty to use defaults)
		})
	end,
}
