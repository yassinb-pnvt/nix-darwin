-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd("packer.nvim")

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({ "folke/trouble.nvim", requires = { "nvim-tree/nvim-web-devicons" } })

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "nvim-telescope/telescope-file-browser.nvim" })

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({
		"ellisonleao/gruvbox.nvim",
		as = "gruvbox",
	})
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "folke/tokyonight.nvim", as = "tokyo" })

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-context")
	use("nvim-treesitter/playground")
	use("theprimeagen/harpoon")
	use("mbbill/undotree")
	use("tpope/vim-surround")
	use("tpope/vim-repeat")

	use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })
	use({ "sindrets/diffview.nvim" })

	use("folke/neodev.nvim")

	use("simrat39/inlay-hints.nvim")
	use("simrat39/rust-tools.nvim")
	-- LSP Support
	use({ "neovim/nvim-lspconfig" })
	use({ "williamboman/mason.nvim" })
	use({ "mhartington/formatter.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })

	-- Autocompletion
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-emoji" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "hrsh7th/cmp-nvim-lsp-signature-help" })
	-- LaTeX
	-- use({ "hrsh7th/cmp-omni" })

	-- Snippets
	use({ "L3MON4D3/LuaSnip" })
	use({ "rafamadriz/friendly-snippets" })
	use({ "j-hui/fidget.nvim", tag = "legacy" })

	use("folke/zen-mode.nvim")

	use("almo7aya/openingh.nvim")

	use({
		"m4xshen/hardtime.nvim",
		requires = {
			{ "MunifTanjim/nui.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
	})

	use({ "tigion/nvim-asciidoc-preview" })
end)
