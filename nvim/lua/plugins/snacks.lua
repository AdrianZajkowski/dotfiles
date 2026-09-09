vim.pack.add({
	"https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
	lazygit = {
		enabled = true,
		win = {
			height = 0.99,
			width = 0,
		},
	},
	indent = {
		enabled = true,
	},
})

vim.keymap.set("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Lazygit open" })
