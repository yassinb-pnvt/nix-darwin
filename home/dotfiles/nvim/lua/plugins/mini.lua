return {
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.surround").setup()
			require("mini.statusline").setup({ use_icons = true })
			require("mini.tabline").setup({})
		end,
	},
}
