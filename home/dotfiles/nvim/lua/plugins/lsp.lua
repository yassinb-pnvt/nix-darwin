return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
            { "saghen/blink.cmp" }
        },
        opts = {
            servers = {
                lua_ls = {},
                gopls = {},
                nixd = {},
                templ = {},
                ts_ls = {},
            },
        },
        config = function(_, opts)
            local lspconfig = require("lspconfig")
            for server, config in pairs(opts.servers) do
                config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end
            vim.keymap.set('n', 'gK', function()
                local new_config = not vim.diagnostic.config().virtual_lines
                vim.diagnostic.config({ virtual_lines = new_config })
            end, { desc = 'Toggle diagnostic virtual_lines' })
        end,
    },
}
