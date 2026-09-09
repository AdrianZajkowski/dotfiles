vim.pack.add({
	"https://github.com/folke/flash.nvim",
})

require("flash").setup({})

vim.keymap.set({ "n", "x", "o" }, "f", function()
	require("flash").jump()
end, { desc = "Flash jump" })
vim.keymap.set({ "n", "x", "o" }, "F", function()
	require("flash").treesitter()
end, { desc = "Flash treesitter" })
