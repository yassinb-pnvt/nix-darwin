return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        config = function()
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
                },
                extensions = {
                    fzf = {}
                }
            })

            require("telescope").load_extension("fzf")

            vim.keymap.set("n", "<leader>sd", require("telescope.builtin").find_files,
                { desc = "[S]earch [d]irectory using Telescope." })
            vim.keymap.set("n", "<leader>sc", function()
                require("telescope.builtin").find_files {
                    cwd = vim.fn.stdpath("config")
                }
            end, { desc = "[S]earch [c]onfig using Telescope." })
            vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep,
                { desc = "[S]earch by [G]rep Telescope" })

            vim.keymap.set(
                "n",
                "<leader>so",
                require("telescope.builtin").oldfiles,
                { desc = '[S]earch [o]ld files using Telescope' }
            )
            vim.keymap.set("n", "<leader>sb", require("telescope.builtin").buffers,
                { desc = "[S] [b]uffers using Telescope." })
            vim.keymap.set("n", "<C-p>", require("telescope.builtin").git_files, { desc = "Search through git files Telescope." })
        end
    },
}
