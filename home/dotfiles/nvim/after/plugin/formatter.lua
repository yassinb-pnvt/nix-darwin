-- Utilities for creating configurations
local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		java = { require("formatter.filetypes.java").google_java_format },
		lua = { require("formatter.filetypes.lua").stylua },
		go = { require("formatter.filetypes.go").gofmt },
		templ = { vim.lsp.buf.format },
		typescriptreact = { require("formatter.filetypes.typescriptreact").prettier },
		sh = { require("formatter.filetypes.sh").shfmt },
		rust = { require("formatter.filetypes.rust").rustfmt },
		c = { require("formatter.filetypes.c").clangformat },
		cpp = { require("formatter.filetypes.cpp").clangformat },
		nix = { require("formatter.filetypes.nix").alejandra },
		python = { require("formatter.filetypes.python").black },
		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})
