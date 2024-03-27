local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettierd", "prettier" } },
		typescript = { { "prettier" } },
		typescriptreact = { { "prettier" } },
		javascriptreact = { { "prettier" } },
		nix = { { "alejandra" } },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

vim.keymap.set("n", "<leader>f", function()
	conform.format({ bufnr = vim.api.nvim_get_current_buf() })
end)
