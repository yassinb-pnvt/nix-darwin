local prettier_config = { "prettier", stop_after_first = true }
return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "ruff_fix", "ruff_format" },
				-- Use a sub-list to run only the first available formatter
				javascript = prettier_config,
				typescript = prettier_config,
				html = prettier_config,
				typescriptreact = prettier_config,
				javascriptreact = prettier_config,
				nix = { "nixfmt" },
				astro = prettier_config,
				go = { "gofmt" },
				markdown = prettier_config,
				ocaml = { "ocamlformat" },
			},
		},
	},
}
