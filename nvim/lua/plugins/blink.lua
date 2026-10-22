vim.pack.add({
	"https://github.com/saghen/blink.lib",
	{ src = "https://github.com/saghen/blink.cmp", version = "main" },
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/mikavilpas/blink-ripgrep.nvim",
})

require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("blink.cmp")
cmp.build():pwait()

cmp.setup({
	keymap = {
		preset = "super-tab",
		["<C-g>"] = {
			function(c)
				return c.show({ providers = { "ripgrep" } })
			end,
		},
	},

	snippets = { preset = "luasnip" },

	completion = {
		menu = {
			border = "rounded",
			draw = { treesitter = { "lsp" } },
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = { border = "rounded" },
		},
	},

	signature = {
		enabled = true,
		window = { border = "rounded" },
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		providers = {
			ripgrep = {
				module = "blink-ripgrep",
				name = "Ripgrep",
				opts = {},
			},
		},
	},

	fuzzy = { implementation = "rust" },
})

vim.lsp.config("*", {
	capabilities = cmp.get_lsp_capabilities(),
})
