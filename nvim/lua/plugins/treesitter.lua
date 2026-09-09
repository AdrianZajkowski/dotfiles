vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

local ensure = { "go", "gomod", "gosum", "gowork", "lua", "javascript", "typescript", "tsx", "json" }

require("nvim-treesitter").install(ensure)

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go", "gomod", "gosum", "gowork", "lua", "javascript", "typescript", "typescriptreact", "json" },
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
