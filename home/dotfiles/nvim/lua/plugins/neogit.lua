return {
	{
		"TimUntersberger/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",

			"sindrets/diffview.nvim", -- optional - Diff integration
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "<leader>gs", "<Cmd>Neogit<Cr>" },
		},
		config = true,
	},
}
