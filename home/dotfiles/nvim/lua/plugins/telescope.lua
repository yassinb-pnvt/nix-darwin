return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for install instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
			{ "nvim-telescope/telescope-file-browser.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			local ts = require("telescope")
			local builtin = require("telescope.builtin")
			ts.load_extension("live_grep_args")

			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp Telescope" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps Telescope" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles Telescope" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord Telescope" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep Telescope" })
			vim.keymap.set("n", "<leader>srg", ts.extensions.live_grep_args.live_grep_args, {})
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics Telescope" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume Telescope" })
			vim.keymap.set(
				"n",
				"<leader>s.",
				builtin.oldfiles,
				{ desc = '[S]earch Recent Files ("." for repeat) Telescope' }
			)
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers Telescope" })
			vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Search Git files Telescope" })
			vim.keymap.set("n", "<leader>slr", builtin.lsp_references, { desc = "Search LSP references Telescope" })
			vim.keymap.set("n", "<leader>sc", function()
				builtin.find_files({ cwd = "~/.config/nvim/" })
			end, { desc = "[S]earch [c]onfig files Telescope" })

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
			end, { desc = "[/] Fuzzily search in current buffer Telescope" })

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
		end,
	},
}
