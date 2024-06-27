local opts = {
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "ruff_fix", "ruff_format" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettierd", "prettier" } },
		typescript = { { "prettier" } },
		html = { { "prettierd", "prettier" } },
		typescriptreact = { { "prettier" } },
		javascriptreact = { { "prettier" } },
		nix = { "nixfmt" },
		astro = { { "prettierd", "prettier" } },
		go = { "gofmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = false,
	},
}

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
		opts = opts,
	},
}
