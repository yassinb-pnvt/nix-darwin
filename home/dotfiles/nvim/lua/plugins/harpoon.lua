return {
	{
		"theprimeagen/harpoon",
		config = function()
			require("harpoon").setup({
				menu = {
					width = vim.api.nvim_win_get_width(0) - 4,
				},
			})

			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "<leader>a", mark.add_file)
			vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

			vim.keymap.set("n", "<Esc>[;", "<C-Semicolon>")
			vim.keymap.set("n", "<C-j>", function()
				ui.nav_file(1)
			end)
			vim.keymap.set("n", "<C-k>", function()
				ui.nav_file(2)
			end)
			vim.keymap.set("n", "<C-l>", function()
				ui.nav_file(3)
			end)
			vim.keymap.set("n", "Harpoon4", function()
				ui.nav_file(4)
			end)
			vim.keymap.set("n", "<leader><C-j>", function()
				ui.nav_file(5)
			end)
			vim.keymap.set("n", "<leader><C-k>", function()
				ui.nav_file(6)
			end)
		end,
	},
}
