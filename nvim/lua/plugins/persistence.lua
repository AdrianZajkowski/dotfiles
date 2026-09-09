vim.pack.add({
	"https://github.com/folke/persistence.nvim",
})

require("persistence").setup({})

vim.keymap.set("n", "<leader>ss", function()
	require("persistence").load()
end, { desc = "Restore session for current directory" })
