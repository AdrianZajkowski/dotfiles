return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
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
	},
	keys = {
		{
			"<leader>c",
			function()
				Snacks.bufdelete.delete()
			end,
			desc = "Buffer close",
		},
		{
			"<C-c>",
			function()
				Snacks.bufdelete.other()
			end,
			desc = "Buffer close all without current",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit open",
		},
	},
}
