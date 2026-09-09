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
	bufdelete = {
		enabled = true,
	},
})

vim.keymap.set("n", "<leader>c", function()
	Snacks.bufdelete.delete()
end, { desc = "Buffer close" })

vim.keymap.set("n", "<C-c>", function()
	Snacks.bufdelete.other()
end, { desc = "Buffer close all without current" })

vim.keymap.set("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Lazygit open" })
