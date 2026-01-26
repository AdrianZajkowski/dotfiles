return {
	-- "catppuccin/nvim",
	-- name = "catppuccin",
	-- priority = 1000,
	-- config = function()
	-- 	require("catppuccin").setup({
	-- 		flavour = "mocha",
	-- 		custom_highlights = function(colors)
	-- 			return {
	-- 				String = { fg = "#99d1db" },
	-- 			}
	-- 		end,
	-- 		transparent_background = true,
	-- 		float = {
	-- 			transparent = true,
	-- 			solid = false,
	-- 		},
	-- 		integrations = {
	-- 			cmp = true,
	-- 			gitsigns = true,
	-- 			telescope = true,
	-- 			nvimtree = true,
	-- 			bufferline = true,
	-- 			which_key = true,
	-- 		},
	-- 	})
	-- 	vim.cmd("colorscheme catppuccin")
	-- end,

	"rose-pine/neovim",
	name = "rose-pine",
	priority = 1000,
	config = function()
		require("rose-pine").setup({
			variant = "moon",
			styles = {
				-- italic = false,
				transparency = true,
			},
		})
		vim.cmd("colorscheme rose-pine")
	end,
}
