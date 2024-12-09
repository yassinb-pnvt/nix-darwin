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
        },
        config = function()
            require("lspconfig").lua_ls.setup {}
        end,
    },
}

-- local function on_attach(client, bufnr)
-- 	local opts = { buffer = bufnr, remap = false }
--
-- 	vim.keymap.set(
-- 		"n",
-- 		"<leader>q",
-- 		vim.diagnostic.setloclist,
-- 		{ desc = "Open diagnostic [Q]uickfix list" }
-- 	)
-- 	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
-- 	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
-- 	vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
-- 	vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
-- 	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
-- 	vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
-- 	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
-- 	vim.keymap.set("n", "<leader>td", vim.lsp.buf.type_definition, opts)
-- 	vim.keymap.set("i", "<C-j>", vim.lsp.buf.signature_help, opts)
--
-- 	vim.keymap.set("n", "<leader>lih", function()
-- 		---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
-- 		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
-- 	end, opts)
-- end
--
-- -- Enable the following language servers
-- --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
-- --
-- --  Add any additional override configuration in the following tables. They will be passed to
-- --  the `settings` field of the server config. You must look up that documentation yourself.
-- --
-- --  If you want to override the default filetypes that your language server will attach to you can
-- --  define the property 'filetypes' to the map in question.
-- local servers = {
-- 	html = { filetypes = { "html", "twig", "hbs" } },
-- 	pyright = {
-- 		pyright = {
-- 			disableOrganizeImports = true,
-- 		},
-- 		Python = {
-- 			ignore = { "*" },
-- 		},
-- 	},
-- 	lua_ls = {
-- 		Lua = {
-- 			workspace = { checkThirdParty = false },
-- 			telemetry = { enable = true },
-- 		},
-- 	},
-- 	tailwindcss = {
-- 		filetypes = { "templ" },
-- 	},
-- }
--
-- -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)


-- require("lspconfig").ruff.setup({
-- 	on_attach = function(client, _)
-- 		if client.name == "ruff" then
-- 			-- Disable hover in favor of Pyright
-- 			client.server_capabilities.hoverProvider = false
-- 		end
-- 	end,
-- })
--
-- require("lspconfig").nixd.setup({})
-- require("lspconfig").ocamllsp.setup({
-- 	on_attach = function()
-- 		vim.keymap.set("n", "<leader>ii", function()
-- 			local documentUri = vim.lsp.util.make_text_document_params(0).uri
-- 			vim.lsp.buf_request(0, "ocamllsp/switchImplIntf", documentUri, function(err, result, _, _)
-- 				if err then
-- 					print("Error:", err)
-- 					return
-- 				end
--
-- 				-- Handle the result here
-- 				print("Result:", vim.inspect(result))
-- 			end)
-- 		end, {})
-- 	end,
--
-- 	-- cmd = { "dune", "tools", "exec", "ocamllsp" },
-- 	cmd = { "dune", "tools", "exec", "ocamllsp" },
-- })
--
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
-- 	border = "rounded",
-- })
--
-- vim.diagnostic.config({
-- 	float = {
-- 		border = "single",
-- 	},
-- })
