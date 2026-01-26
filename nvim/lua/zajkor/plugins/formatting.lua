return {
	{
		"stevearc/conform.nvim",
		opts = {
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				css = { "prettier" },
				html = { "prettier" },
				yaml = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
			php = { "php_cs_fixer" },
			go = { "goimports", "gofmt" },
		},
			-- formatters = {
			--     php_cs_fixer = {
			--         command = "php-cs-fixer",
			--         args = {
			--             "fix",
			--             "--using-cache=no",
			--             "$FILENAME",
			--         },
			--         stdin = false,
			--     },
			-- },
		},
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
}
