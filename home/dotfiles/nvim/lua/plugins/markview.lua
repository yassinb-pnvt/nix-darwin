return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	-- opts = {
	-- 	modes = {},
	-- 	hybrid_mods = nil,
	-- },
	keys = {
		{ "<leader>md", "<Cmd>Markview toggle<Cr>" },
	},
	dependencies = {
		-- You will not need this if you installed the
		-- parsers manually
		-- Or if the parsers are in your $RUNTIMEPATH
		"nvim-treesitter/nvim-treesitter",

		"nvim-tree/nvim-web-devicons",
	},
}
