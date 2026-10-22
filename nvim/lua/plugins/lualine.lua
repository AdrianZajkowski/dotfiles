vim.pack.add({
	"https://github.com/nvim-lualine/lualine.nvim",
})

require("lualine").setup({
	sections = {
		lualine_c = {
			"filename",
			{
				"searchcount",
				maxcount = 999,
				timeout = 500,
			},
		},
		lualine_x = {
			{
				function()
					return "recording @" .. vim.fn.reg_recording()
				end,
				cond = function()
					return vim.fn.reg_recording() ~= ""
				end,
				color = { fg = "#ff9e64" },
			},
			"diagnostics",
			"filetype",
		},
	},
})
