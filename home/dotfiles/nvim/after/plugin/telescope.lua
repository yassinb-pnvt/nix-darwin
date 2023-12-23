local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>rg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>sd', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>sw', builtin.lsp_workspace_symbols, {})
vim.keymap.set('n', '<leader>en', function() builtin.find_files({ cwd = "~/.config/nvim/" }) end, {})
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
require("telescope").load_extension "file_browser"
vim.keymap.set('n', '<leader>fb', "<Cmd> Telescope file_browser<CR>", {})
