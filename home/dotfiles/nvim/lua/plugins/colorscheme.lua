-- return {
-- 	"folke/tokyonight.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {
-- 		transparent_background = false, -- disables setting the background color.
-- 	},
-- 	init = function()
-- 		-- vim.cmd.colorscheme("tokyonight-storm")
-- 	end,
-- }
return {
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		name = "catppuccin",
		opts = {
			transparent_background = true,
		},
		init = function()
			vim.cmd.colorscheme("catppuccin-mocha")
			-- vim.cmd.colorscheme("catppuccin-latte")
		end,
	},
}
