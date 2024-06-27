return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		keys = {
			{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
		},
		opts = {
			keymaps = {
				["<C-p>"] = false,
			},
		},
	},
}
