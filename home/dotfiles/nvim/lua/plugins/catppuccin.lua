return {
	{
		"catppuccin/nvim",
		disabled = true,
		disable = true,
		lazy = false,
		priority = 1000,
		name = "catppuccin",
		init = function()
			-- Load the colorscheme here.
			-- vim.cmd.colorscheme("catppuccin-frappe")

			-- You can configure highlights by doing something like:
			-- vim.cmd.hi("Comment gui=none")
		end,
	},
}
