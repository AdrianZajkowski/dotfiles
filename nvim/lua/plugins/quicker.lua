vim.pack.add({
	"https://github.com/stevearc/quicker.nvim",
})

local quicker = require("quicker")

quicker.setup({
	keys = {
		{ ">", function() quicker.expand({ before = 2, after = 2, add_to_existing = true }) end, desc = "Expand quickfix context" },
		{ "<", function() quicker.collapse() end, desc = "Collapse quickfix context" },
	},
})

vim.keymap.set("n", "<leader>xx", function() quicker.toggle() end, { desc = "Toggle quickfix" })
vim.keymap.set("n", "<leader>xl", function() quicker.toggle({ loclist = true }) end, { desc = "Toggle loclist" })
vim.keymap.set("n", "<leader>xd", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })
