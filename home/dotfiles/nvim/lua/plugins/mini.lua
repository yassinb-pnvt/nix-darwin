return {
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.surround").setup()
			require("mini.statusline").setup({ use_icons = vim.g.have_nerd_font })
			-- require("mini.tabline").setup({})
		end,
	},
}
