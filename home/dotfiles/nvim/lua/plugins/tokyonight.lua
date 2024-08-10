return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	init = function()
		-- Load the colorscheme here.
		vim.cmd.colorscheme("tokyonight-storm")

		-- You can configure highlights by doing something like:
		-- vim.cmd.hi("Comment gui=none")
	end,
}
