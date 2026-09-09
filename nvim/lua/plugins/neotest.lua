-- plenary + nvim-treesitter are already added by other plugin modules.
vim.pack.add({
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/antoinemadec/FixCursorHold.nvim",
	"https://github.com/fredrikaverpil/neotest-golang",
	"https://github.com/olimorris/neotest-phpunit",
	"https://github.com/nvim-neotest/neotest",
})

require("neotest").setup({
	adapters = {
		require("neotest-golang")({}),
		require("neotest-phpunit")({
			filter_dirs = { ".git", "node_modules", "vendor" },
			phpunit_cmd = function()
				return { "php", "-d", "memory_limit=-1", "vendor/bin/phpunit" }
			end,
		}),
	},
})

vim.keymap.set("n", "<leader>t", "", { desc = "+test" })
vim.keymap.set("n", "<leader>tt", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run File (Neotest)" })
vim.keymap.set("n", "<leader>tT", function()
	require("neotest").run.run(vim.uv.cwd())
end, { desc = "Run All Test Files (Neotest)" })
vim.keymap.set("n", "<leader>tr", function()
	require("neotest").run.run()
end, { desc = "Run Nearest (Neotest)" })
vim.keymap.set("n", "<leader>tl", function()
	require("neotest").run.run_last()
end, { desc = "Run Last (Neotest)" })
vim.keymap.set("n", "<leader>ts", function()
	require("neotest").summary.toggle()
end, { desc = "Toggle Summary (Neotest)" })
vim.keymap.set("n", "<leader>to", function()
	require("neotest").output.open({ enter = true, auto_close = true })
end, { desc = "Show Output (Neotest)" })
vim.keymap.set("n", "<leader>tO", function()
	require("neotest").output_panel.toggle()
end, { desc = "Toggle Output Panel (Neotest)" })
vim.keymap.set("n", "<leader>tS", function()
	require("neotest").run.stop()
end, { desc = "Stop (Neotest)" })
vim.keymap.set("n", "<leader>tw", function()
	require("neotest").watch.toggle(vim.fn.expand("%"))
end, { desc = "Toggle Watch (Neotest)" })
