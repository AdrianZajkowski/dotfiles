return {
	"nvim-lualine/lualine.nvim",
	opts = {
		sections = {
			lualine_x = {
				-- {
				-- required to see macros info in statusline
				-- require("noice").api.statusline.mode.get,
				-- cond = require("noice").api.statusline.mode.has,
				-- color = { fg = "#ff9e64" },
				-- },
				"filetype",
			},
		},
	},
}
