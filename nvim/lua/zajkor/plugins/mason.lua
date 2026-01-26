return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"lua_ls",
				"eslint",
				"gopls",
				"phpactor",
				-- "psalm",
			},
		},
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"prettier",
				"stylua",
				"eslint_d",
				"gopls",
				"phpactor",
				-- "psalm",
				"php-cs-fixer",
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
}
