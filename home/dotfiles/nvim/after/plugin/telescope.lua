local ts = require("telescope")
local builtin = require("telescope.builtin")
ts.load_extension("live_grep_args")

vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>srg", ts.extensions.live_grep_args.live_grep_args, {})
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>slr", builtin.lsp_references, {})
vim.keymap.set("n", "<leader>sc", function()
	builtin.find_files({ cwd = "~/.config/nvim/" })
end, {})

ts.load_extension("file_browser")
vim.keymap.set(
	"n",
	"<leader>sb",
	":Telescope file_browser path=%:p:h select_buffer=true<CR>",
	{ desc = "[S]earch File [B]rowser" }
)

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

require("telescope").setup({
	pickers = {
		lsp_references = {
			theme = "dropdown",
			layout_config = {
				width = 100,
				prompt_position = "top",
				anchor = "N",
			},
		},
		git_files = {
			theme = "dropdown",
			previewer = false,
			hidden = true,
			wrap_results = true,
			layout_config = {
				width = 100,
				prompt_position = "top",
				anchor = "N",
			},
			mappings = {
				i = {
					["?"] = require("telescope.actions.layout").toggle_preview,
				},
			},
		},
		buffers = {
			mappings = {
				i = {
					["<c-d>"] = "delete_buffer",
				},
			},
		},
	},
})
